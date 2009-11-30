# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{crazy_ivan}
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Edward Ocampo-Gooding"]
  s.date = %q{2009-11-29}
  s.default_executable = %q{crazy_ivan}
  s.description = %q{Continuous integration should really just be a script that captures the output of running your project update & test commands and presents recent results in a static html page.

    By keeping test reports in json, per-project CI configuration in 3 probably-one-line scripts, things are kept simple, quick, and super extensible.

    Want to use git, svn, or hg? No problem.
    Need to fire off results to Twitter or Campfire? It's one line away.

    CI depends on cron.}
  s.email = %q{edward@edwardog.net}
  s.executables = ["crazy_ivan"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc",
     "TODO"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "TODO",
     "VERSION",
     "bin/crazy_ivan",
     "crazy_ivan.gemspec",
     "lib/crazy_ivan.rb",
     "lib/crazy_ivan/html_asset_crush.rb",
     "lib/crazy_ivan/report_assembler.rb",
     "lib/crazy_ivan/test_runner.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/CHANGES",
     "lib/crazy_ivan/vendor/json-1.1.7/GPL",
     "lib/crazy_ivan/vendor/json-1.1.7/README",
     "lib/crazy_ivan/vendor/json-1.1.7/RUBY",
     "lib/crazy_ivan/vendor/json-1.1.7/Rakefile",
     "lib/crazy_ivan/vendor/json-1.1.7/TODO",
     "lib/crazy_ivan/vendor/json-1.1.7/VERSION",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkComparison.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkExt#generator_fast-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkExt#generator_fast.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkExt#generator_pretty-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkExt#generator_pretty.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkExt#generator_safe-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkExt#generator_safe.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkExt.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkPure#generator_fast-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkPure#generator_fast.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkPure#generator_pretty-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkPure#generator_pretty.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkPure#generator_safe-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkPure#generator_safe.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkPure.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkRails#generator-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkRails#generator.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/GeneratorBenchmarkRails.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkComparison.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkExt#parser-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkExt#parser.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkExt.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkPure#parser-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkPure#parser.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkPure.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkRails#parser-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkRails#parser.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkRails.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkYAML#parser-autocorrelation.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkYAML#parser.dat",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/data-p4-3GHz-ruby18/ParserBenchmarkYAML.log",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/generator_benchmark.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/benchmarks/parser_benchmark.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/bin/edit_json.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/bin/prettify_json.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/data/example.json",
     "lib/crazy_ivan/vendor/json-1.1.7/data/index.html",
     "lib/crazy_ivan/vendor/json-1.1.7/data/prototype.js",
     "lib/crazy_ivan/vendor/json-1.1.7/doc-templates/main.txt",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/generator/extconf.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/generator/generator.c",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/generator/unicode.c",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/generator/unicode.h",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/parser/extconf.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/parser/parser.c",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/parser/parser.rl",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/parser/unicode.c",
     "lib/crazy_ivan/vendor/json-1.1.7/ext/json/ext/parser/unicode.h",
     "lib/crazy_ivan/vendor/json-1.1.7/install.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/Array.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/FalseClass.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/Hash.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/Key.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/NilClass.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/Numeric.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/String.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/TrueClass.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/add/core.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/add/rails.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/common.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/editor.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/ext.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/json.xpm",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/pure.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/pure/generator.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/pure/parser.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/lib/json/version.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail1.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail10.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail11.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail12.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail13.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail14.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail18.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail19.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail2.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail20.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail21.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail22.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail23.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail24.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail25.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail27.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail28.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail3.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail4.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail5.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail6.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail7.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail8.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/fail9.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/pass1.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/pass15.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/pass16.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/pass17.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/pass2.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/pass26.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/fixtures/pass3.json",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/test_json.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/test_json_addition.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/test_json_fixtures.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/test_json_generate.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/test_json_rails.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/tests/test_json_unicode.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/tools/fuzz.rb",
     "lib/crazy_ivan/vendor/json-1.1.7/tools/server.rb",
     "lib/crazy_ivan/vendor/json.rb",
     "lib/crazy_ivan/version.rb",
     "templates/css/ci.css",
     "templates/index.html",
     "templates/javascript/builder.js",
     "templates/javascript/controls.js",
     "templates/javascript/date.js",
     "templates/javascript/dragdrop.js",
     "templates/javascript/effects.js",
     "templates/javascript/json-template.js",
     "templates/javascript/prototype.js",
     "templates/javascript/scriptaculous.js",
     "templates/javascript/slider.js",
     "test/crazy_ivan_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/edward/crazy_ivan}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Crazy Ivan (CI) is simplest possible continuous integration tool.}
  s.test_files = [
    "test/crazy_ivan_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

