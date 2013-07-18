# ActiveCampaign

Ruby wrapper for (ActiveCampaign)[http://activecampaign.com] API

## Installation

Add this line to your application's Gemfile:

    gem 'active_campaign'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_campaign

## Usage

1. Initialize the client

```ruby
client = ActiveCampaign::Client.new('https://your-domain.api-us1.com', 'api-key')
```

2. Create a List

```ruby
params = {name: 'Testing List', subscription_notify: 'noitfy.me@test.com', unsubscription_notify: 'notify.me@test.com', to_name: 'Moderator', carboncopy: 'me@est.com', sender_name: 'Your Name', sender_addr1: 'Lazimpat', sender_city: 'Kathmandu', sender_state: 'Bagmati', sender_zip: '33000', sender_country: 'Nepal'}

response = client.list_add(params)
list_id = response["list_id"]
```

3. Adding custom list fields for personalization

```ruby
params = { title: 'Birthday', perstag: "BIRTHDATE", :"p[#{list_id}]"=>"#{list_id}", type: "1", req: "1", show_in_list: "1" }
response = client.list_field_add(params)
```

4. Adding Contacts

```ruby
params = {:"field[%BIRTHDATE%,0]" => '1982 Jan 11', :email => 'user2@test.com', :first_name => 'User2', :last_name => 'Last2', :"p[#{list_id}]" => "#{list_id}"}
response = client.contact_add(params)
```

5. Adding Message Template

```ruby
params = {:format => "mime",
          :subject => "TEST 1 message template",
          :fromemail => "test@gmail.com",
          :fromname => "John Doe",
          :reply2 => "test@gmail.com",
          :priority => "3",
          :charset => "UTF-8",
          :encoding => "quoted-printable",
          :htmlconstructor => "editor",
          :html => "<h1>My Test Message</h1>\n\n<p>Your birthday %BIRTHDAY%.\n\nThis is a test message created via the API with PERSONALIZATION Tag.</p>",
          :textconstructor => "editor",
          :text => "# My Test Message\n\nThis is a test message created via the API.",
          :"p[#{list_id}]" => "#{list_id}"
          response = client.message_add(params)
          message_id = response['id']
```
6. Create Campaign

```ruby
params = { :name=>"Test 1 Campaign", :type=>"single", :segmentid=>"0", :sdate=>"2013-07-10 04:51:00",
  :status=>"1", :public=>"1", :tracklinks=>"all", :trackreads=>"1", :trackreplies=>"0", :trackreadsanalytics=>"0", :'p[9]'=> '9', :"m[#{message_id}]" => "#{message_id}"}
response = client.campaign_create(params)
campaign_id = response['id']
```

7. Send the emails

```ruby
params = { :action => "test", :email =>"your@example.com", :campaignid =>"#{campaign_id}", :messageid =>"#{message_id}", :type =>"mime" }
response = client.campaign_send(params)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
