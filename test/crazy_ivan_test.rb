require 'test_helper'
require 'tmpdir'

class CrazyIvanTest < Test::Unit::TestCase
  def setup
    Dir.chdir(File.dirname(__FILE__) + '/..')
  end

  def teardown
    `rm -rf test/ci-results`
  end
  
  def test_setup
    Dir.mkdir('test/projects/some-project')
    
    setup_crazy_ivan
    
    assert File.exists?('test/projects/some-project/.ci/update')
    assert File.exists?('test/projects/some-project/.ci/version')
    assert File.exists?('test/projects/some-project/.ci/test')
    assert File.exists?('test/projects/some-project/.ci/conclusion')
  ensure
    `rm -rf test/projects/some-project`
  end
  
  def test_empty_script_output
  end
  
  def test_runner_for_projects
    setup_crazy_ivan
    run_crazy_ivan do
      projects = JSON.parse(File.open('test/ci-results/projects.json').read)["projects"]
      assert_equal ["broken-tests", "completely-working"], projects
    end
  end
  
  def test_runner_skips_already_tested_versions
    setup_crazy_ivan
    run_crazy_ivan {}
    run_crazy_ivan do
      TestRunner.any_instance.expects(:test!).times(0)
      TestRunner.any_instance.expects(:conclusion!).times(0)
      
      broken_test_results = JSON.parse(File.read('test/ci-results/broken-tests/reports.json'))
      broken_versions = broken_test_results.map {|r| r['version']['output'] }
      assert_equal ["a-valid-version"], broken_versions
      
      working_results = JSON.parse(File.read('test/ci-results/completely-working/reports.json'))
      working_versions = working_results.map {|r| r['version']['output'] }
      assert_equal ["a-valid-version"], working_versions
    end
  end
  
  def test_runner_for_broken_project
    setup_crazy_ivan
    run_crazy_ivan do
      assert File.exists?('test/ci-results/broken-tests/reports.json')
      assert File.exists?('test/ci-results/broken-tests/currently_building.json')
      
      results = JSON.parse(File.read('test/ci-results/broken-tests/reports.json'))
      versions = results.map {|r| r['version']['output'] }
      assert_equal ["a-valid-version"], versions
            
      test_results = results.first
      
      assert_equal "broken-tests", test_results["project_name"]
      
      # FIXME add projects that each fail (exit status non-zero) at different steps (in update, version, test)
      
      # FIXME use a time range here
      assert test_results["timestamp"]["start"]
      assert test_results["timestamp"]["finish"]
      
      assert test_results["update"]["output"]
      assert test_results["update"]["error"]
      assert test_results["update"]["exit_status"] == '0'
      
      assert test_results["version"]["output"]
      assert test_results["version"]["error"]
      assert test_results["version"]["exit_status"] == '0'
      
      assert test_results["test"]["output"]
      assert test_results["test"]["error"]
      assert test_results["test"]["exit_status"] == '1'
      assert test_results["test"]["duration"] # FIXME use a number here
    end
  end
  
  def test_runner_for_working_project
    setup_crazy_ivan
    run_crazy_ivan do
      assert File.exists?('test/ci-results/completely-working/reports.json')
      assert File.exists?('test/ci-results/completely-working/currently_building.json')
      
      results = JSON.parse(File.read('test/ci-results/completely-working/reports.json'))
      versions = results.map {|r| r['version']['output'] }
      assert_equal ["a-valid-version"], versions
            
      test_results = results.first
      
      assert_equal "completely-working", test_results["project_name"]
      
      # FIXME add projects that each fail (exit status non-zero) at different steps (in update, version, test)
      
      # FIXME use a time range here
      assert test_results["timestamp"]["start"]
      assert test_results["timestamp"]["finish"]
      
      assert test_results["update"]["output"]
      assert test_results["update"]["error"]
      assert test_results["update"]["exit_status"] == '0'
      
      assert test_results["version"]["output"]
      assert test_results["version"]["error"]
      assert test_results["version"]["exit_status"] == '0'
      
      assert test_results["test"]["output"]
      assert test_results["test"]["error"]
      assert test_results["test"]["exit_status"] == '0'
    end
  end
  
  def test_external_scripts_not_overwritten
    setup_crazy_ivan
    
    FileUtils.copy('test/projects/completely-working/.ci/version', 'test/projects/completely-working/.ci/version_original')
    
    setup_crazy_ivan
    
    # the completely-working/.ci/version is different from the default setup, so it would
    # have been changed if external scripts were overwritten
    assert FileUtils.compare_file('test/projects/completely-working/.ci/version_original', 'test/projects/completely-working/.ci/version')
  ensure
    FileUtils.copy('test/projects/completely-working/.ci/version_original', 'test/projects/completely-working/.ci/version')
  end
  
  def test_status_file
    # Enable status copying in the update and test scripts.
    ENV['COPY_STATUS'] = Dir.getwd + '/test/ci-results/status.json'

    setup_crazy_ivan
    run_crazy_ivan do
      status = JSON.parse(File.read('test/ci-results/status.json.update'))
      assert_equal 'Updating completely-working', status['message']
      assert_equal 'completely-working', status['project']
      assert_equal 'update', status['stage']
      assert_in_delta Time.now.to_f, status['timestamp'], 2.0

      status = JSON.parse(File.read('test/ci-results/status.json.test'))
      assert_equal 'Testing completely-working build a-valid-version', status['message']
      assert_equal 'completely-working', status['project']
      assert_equal 'test', status['stage']
      assert_in_delta Time.now.to_f, status['timestamp'], 2.0

      status = JSON.parse(File.read('test/ci-results/status.json'))
      assert_equal 'Idle', status['message']
      assert_equal 'idle', status['class']
      assert_nil status['project']
      assert_nil status['stage']
      assert_in_delta Time.now.to_f, status['timestamp'], 2.0
    end
  end
  
  private
  
  def setup_crazy_ivan()
    Dir.chdir('test/projects') do
      do_silently { CrazyIvan.setup }
    end
  end
  
  def run_crazy_ivan
    Dir.chdir('test/projects') do
      do_silently { CrazyIvan.generate_test_reports_in('../ci-results') }
    end
    yield
  end
end