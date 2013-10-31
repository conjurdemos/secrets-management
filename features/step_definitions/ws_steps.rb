require 'conjur/api'

When(/^I( try)? to create a secret$/) do |try|
  begin
    v = {
      mime_type: 'text/plain',
      kind: 'test-secret'
    }
    variable = JSON.parse(rest_resource['variables'].post(v).body)
    e = {
      name: SecureRandom.uuid,
      variableid: variable['id']
    }
    @response = rest_resource[environment_path]['variables'].post(e)
  rescue RestClient::Exception
    if try
      require 'ostruct'
      @response = OpenStruct.new
      @response.code = $!.http_code
    else
      raise $!
    end
  end
end

Then /^it is allowed$/ do
  [ 200, 201, 204 ].should be_member(@response.code)
end

Then /^I am not authenticated$/ do
  @response.code.should == 401
end

Then /^it is denied$/ do
  @response.code.should == 403
end

Given(/^I am logged in as Alice$/) do
  login_as 'alice'
end

Given(/^I am logged in as Bob$/) do
  login_as 'bob'
end

Given(/^I am logged in as Claire$/) do
  login_as 'claire'
end

Then(/^the response should be "(.*?)"$/) do |response|
  @response.body.should == response
end