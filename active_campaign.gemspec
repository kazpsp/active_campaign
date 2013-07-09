# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_campaign/version'

Gem::Specification.new do |gem|
  gem.name          = "active_campaign"
  gem.version       = ActiveCampaign::VERSION
  gem.authors       = ["Millisami"]
  gem.email         = ["millisami@gmail.com"]
  gem.description   = %q{A Ruby wrapper for ActiveCampaign.com API}
  gem.summary       = %q{Wrapper for ActiveCampaign.com API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock', '~> 1.11.0'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'activesupport'
  gem.add_development_dependency 'httplog'

  gem.add_runtime_dependency 'httparty'
end
