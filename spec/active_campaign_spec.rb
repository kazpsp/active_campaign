require_relative 'spec_helper'

describe ActiveCampaign do
  let(:client) do
    client = ActiveCampaign::Client.new('https://tfm.api-us1.com',
             'eeb0aae2459ee1c0d9a820342acc2d011902d5ff640c770d2821198973f7e6d2154a08f8')
  end

  context "configuration" do
    it "set the api key" do
      ac = ActiveCampaign::Client.new("https://tfm.api-us1.com", "api-key")
      expect(ac.api_key).to eq("api-key")
    end
  end

  context "manage list" do
    it "create a new list", :vcr, record: :new_episodes do
      params = {name: 'Test List', subscription_notify: 'noitfy.me@test.com', unsubscription_notify: 'notify.me@test.com', to_name: 'Milli', carboncopy: 'milli@est.com', sender_name: 'TFM', sender_addr1: 'Lazimpat', sender_city: 'Kathmandu', sender_state: 'Bagmati', sender_zip: '33000', sender_country: 'Nepal'}

      response = client.list_add(params)
      expect(response['result_message']).to eql('List added')
      expect(response['result_code']).to eql(1)
    end

    it "list all the lists", :vcr, record: :new_episodes do
      new_list_params = {name: 'Test List 2', sender_name: 'TFM', sender_addr1: 'Lazimpat', sender_city: 'Kathmandu', sender_state: 'Bagmati', sender_zip: '33000', sender_country: 'Nepal'}
      client.list_add(new_list_params)

      params = {ids: 'all', full: 1}

      response = client.list_list(params)
      expect(response['2']['name']).to eql('Test List 2')
      expect(response['2']['stringid']).to eql('test-list-2')
    end
  end

  context "manage contacts" do
    it "add new contact", :vcr, record: :new_episodes do
      params = {:email => 'user1@test.com', :first_name => 'User1', :last_name => 'Last1', :'p[9]' => '9'}
      response = client.contact_add(params)
      expect(response['result_code']).to eql(1)
      expect(response['result_message']).to eql("Contact added")
    end
  end

  context "manage messages aka template" do
    it "create a new message template", :vcr, record: :new_episodes do
      params = {:format => "mime",
                :subject => "TEST 1 message template",
                :fromemail => "test@gmail.com",
                :fromname => "John Doe",
                :reply2 => "test@gmail.com",
                :priority => "3",
                :charset => "UTF-8",
                :encoding => "quoted-printable",
                :htmlconstructor => "editor",
                :html => "<h1>My Test Message</h1>\n\n<p>This is a test message created via the API.</p>",
                :textconstructor => "editor",
                :text => "# My Test Message\n\nThis is a test message created via the API.",
                :'p[9]' => "9"}
      response = client.message_add(params)
      expect(response['result_code']).to eq(1)
      expect(response['result_message']).to eql('Email Message added')
      expect(response['subject']).to eql('TEST 1 message template')
    end
  end

  context "manage campaigns" do
    it "create a new campaign", :vcr, record: :new_episodes do
      params = { :name=>"Test 1 Campaign", :type=>"single", :segmentid=>"0", :sdate=>"2013-07-10 04:51:00",
        :status=>"1", :public=>"1", :tracklinks=>"all", :trackreads=>"1", :trackreplies=>"0", :trackreadsanalytics=>"0", :'p[9]'=> '9', :'m[27]'=> '27'}
      response = client.campaign_create(params)
      expect(response['result_code']).to eq(1)
      expect(response['result_message']).to eq('Campaign saved')
    end

    it "send test campaign", :vcr, record: :new_episodes do
      params = { :action => "test", :email =>"millisami@gmail.com", :campaignid =>"2", :messageid =>"27", :type =>"mime" }
      response = client.campaign_send(params)
      expect(response['result_code']).to eq(1)
      expect(response['result_message']).to eql('Message sent')
      expect(response['result']).to eql(1)
    end
  end
end
