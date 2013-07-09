require_relative 'spec_helper'

describe ActiveCampaign do
  context "configuration" do
    it "set the api key" do
      ac = ActiveCampaign::Client.new("https://tfm.api-us1.com", "api-key")
      expect(ac.api_key).to eq("api-key")
    end
  end

  context "manage list" do
    it "create a new list", :vcr, record: :new_episodes do

      params = {name: 'Test List', subscription_notify: 'noitfy.me@test.com', unsubscription_notify: 'notify.me@test.com', to_name: 'Milli', carboncopy: 'milli@est.com', sender_name: 'TFM', sender_addr1: 'Lazimpat', sender_city: 'Kathmandu', sender_state: 'Bagmati', sender_zip: '33000', sender_country: 'Nepal'}

      client = ActiveCampaign::Client.new('https://tfm.api-us1.com',
               'eeb0aae2459ee1c0d9a820342acc2d011902d5ff640c770d2821198973f7e6d2154a08f8')

      response = client.list_add(params)
      expect(response['result_message']).to eql('List added')
      expect(response['result_code']).to eql(1)
    end
  end
end
