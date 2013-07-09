require 'active_campaign'
require 'vcr'
require 'webmock'
require 'pry'
require 'active_support/core_ext'

APP_ROOT = File.expand_path('../../', __FILE__)

# https://github.com/vcr/vcr/wiki/How-to-solve-cassette-conflicts-on-GIT
VCR.configure do |config|
  config.hook_into :webmock
  if defined?(APP_ROOT)
    config.cassette_library_dir = (APP_ROOT + "/spec/vcr")
  else
    raise "APP_ROOT not set. Set it up properly first."
  end
  config.configure_rspec_metadata!
  config.preserve_exact_body_bytes { true }
  config.default_cassette_options = {
    re_record_interval: 10.weeks
  }
  config.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.around(:each, :vcr) do |example|
    name = example.metadata[:use_cassette] || example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/,"_")
    # The following options is for extracting the vcr record options
    # e.g.
    # it "...", :vcr, record: :new_episodes do
    # ....
    # end
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
