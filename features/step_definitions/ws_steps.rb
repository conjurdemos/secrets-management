require 'conjur/api'

When(/^I( try)? to update secret$/) do |try|
  value = SecureRandom.uuid
  begin
    variable.add_value value
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

Given(/^I am logged in as user $/) do
  login_as username(user, :user)
end

Given(/^I am logged in as host $/) do
  login_as username(host, :host)
end


Then(/^the response should be "(.*?)"$/) do |response|
  @response.body.should == response
end