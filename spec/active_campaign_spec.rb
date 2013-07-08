require_relative 'spec_helper'

describe ActiveCampaign do
  context "configuration" do
    it "set the api key" do
      ActiveCampaign.api_key = "api-key"
      expect(ActiveCampaign.api_key).to eq("api-key")
    end
    it "set the response output type" do
      ActiveCampaign.api_output = "json"
      expect(ActiveCampaign.api_output).to eq("json")
    end
  end
end