require 'cgi'

class TestRunner
  def initialize(project_path, report_assembler)
    @project_path = project_path
    @results = {:project_name => File.basename(@project_path),
                :version => {:output => '', :error => '', :exit_status => ''},
                :update  => {:output => '', :error => '', :exit_status => ''},
                :test    => {:output => '', :error => '', :exit_status => ''},
                :timestamp => {:start => nil, :finish => nil}}
    @report_assembler = report_assembler
  end
  
  attr_reader :results
  
  def project_name
    @results[:project_name]
  end

  def check_for_valid_scripts
    check_script('update')
    check_script('version')
    check_script('test')
    check_script('conclusion')
  end
  
  def script_path(name)
    script_path = File.join('.ci', name)
  end
  
  def check_script(name)
    script_path = script_path(name)
    
    Dir.chdir(@project_path) do
      if File.exists?(script_path)
        if !File.stat(script_path).executable?
          msg = "#{@project_path}/.ci/#{name} script not executable"
          Syslog.warning msg
          abort msg
        elsif File.open(script_path).read.empty?
          msg = "#{@project_path}/.ci/#{name} script empty"
          Syslog.warning msg
          abort msg
        end
      else
        msg = "#{@project_path}/.ci/#{name} script missing"
        Syslog.warning msg
        abort msg
      end
    end
  end
  
  def run_script(name, options = {})
    output = ''
    error = ''
    exit_status = ''
    
    Dir.chdir(@project_path) do
      Syslog.debug "Opening up the pipe to #{script_path(name)}"
      
      status = Open4::popen4(script_path(name)) do |pid, stdin, stdout, stderr|
        begin
          stdin.close  # Close to prevent hanging if the script wants input
        
          until stdout.eof? && stderr.eof? do
            ready_io_streams = select( [stdout], nil, [stderr], 3600 )
          
            script_output = ready_io_streams[0].pop
            script_error = ready_io_streams[2].pop
          
            if script_output && !script_output.eof?
              o = script_output.readpartial(4096)
              print o
              output << o
            
              if options[:stream_test_results?]
                @results[:test][:output] = escape(output)
                @report_assembler.update_currently_building(self)
              end
            end
          
            if script_error && !script_error.eof?
              e = script_error.readpartial(4096)
              print e
              error << e
            
              if options[:stream_test_results?]
                @results[:test][:error] = escape(error)
                @report_assembler.update_currently_building(self)
              end
            end
          
            # FIXME - this feels like I'm using IO.select wrong
            if script_output.eof? && script_error.nil?
              # there's no more output to SDOUT, and there aren't any errors
              e = stderr.read
              error << e
              print e
            
              if options[:stream_test_results?]
                @results[:test][:error] = escape(error)
                @report_assembler.update_currently_building(self)
              end
            end
          end
        rescue Lockfile::StolenLockError => e
          lockfile_stolen(name, pid)
          raise e
        end
      end
      
      exit_status = status.exitstatus
    end
    
    return escape(output.chomp), escape(error.chomp), exit_status.to_s
  end
  
  def run_conclusion_script
    # REFACTOR do this asynchronously so the next tests don't wait on running the conclusion
    
    Dir.chdir(@project_path) do
      Syslog.debug "Passing report to conclusion script at #{script_path('conclusion')}"
      errors = ''
      status = Open4.popen4(script_path('conclusion')) do |pid, stdin, stdout, stderr|
        stdin.puts @results.to_json
        stdin.close
        errors = stderr.read
      end
      
      Syslog.err(errors) if status.exitstatus != '0'
      Syslog.debug "Finished executing conclusion script"
    end
    
  rescue Errno::EPIPE
    Syslog.err "Unknown issue in writing to conclusion script."
  end
  
  def start!
    # REFACTOR to just report whichever scripts are invalid
    check_for_valid_scripts
    
    @results[:timestamp][:start] = Time.now
    Syslog.info "Starting CI for #{project_name}"
  end
    
  def update!
    Syslog.debug "Updating #{project_name}"
    @results[:update][:output], @results[:update][:error], @results[:update][:exit_status] = run_script('update')
  end
  
  def version!
    Syslog.debug "Acquiring build version for #{project_name}"
    @results[:version][:output], @results[:version][:error], @results[:version][:exit_status] = run_script('version')
    @results[:version][:output] += '-failed' unless @results[:update][:exit_status] == '0'
  end
  
  def test!
    if @results[:version][:exit_status] == '0'
      Syslog.debug "Testing #{@results[:project_name]} build #{@results[:version][:output]}"
      output, @results[:test][:error], @results[:test][:exit_status] = run_script('test', :stream_test_results? => true)

      if output =~ /E{100,}/
        output = $` + $& + $'.lines.take(50).join + "\n*** #{$&.length} errors detected, output truncated. ***"
      end
      @results[:test][:output] = output
    else
      Syslog.debug "Failed to test #{project_name}; version exit status was #{@results[:version][:exit_status]}"
    end
    
    @results[:timestamp][:finish] = Time.now
    run_conclusion_script
  end
  
  def finished?
    @results[:timestamp][:finish]
  end
  
  def still_building?
    !finished?
  end
  
  private
  
  def escape(text)
    CGI.escapeHTML(text)
  end
  
  def lockfile_stolen(name, pid)
    catch (:success) do
      Syslog.info("Lockfile stolen, interrupting #{name} script (PID #{pid}) ...")
      Process.kill('INT', pid)

      10.times do
        sleep(1)
        throw :success unless process_running?(pid)
      end

      Syslog.info("Forcibly killing #{name} script ...")
      Process.kill('KILL', pid)

      5.times do
        sleep(1)
        throw :success unless process_running?(pid)
      end

      raise "Script refuses to die."
    end
    
    Syslog.info("Successfully terminated #{name} script.")
  rescue Exception => e
    Syslog.err("Error killing #{name} script: #{e.message} (#{e.class})")
  end
  
  def process_running?(pid)
    Process.waitpid(pid, Process::WNOHANG) # reap zombies
    Process.kill(0, pid)
    true
  rescue Errno::ESRCH
    false
  end
end