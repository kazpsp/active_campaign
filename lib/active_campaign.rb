require_relative "active_campaign/version"

module ActiveCampaign
  class << self # :nodoc: all
    attr_accessor :api_key, :api_output
  end
end
