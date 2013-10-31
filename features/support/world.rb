module SecretsManagementWorld
  def rest_resource
    options = { headers: { authorization: @token } }
    host = Conjur::Core::API.host
    RestClient::Resource.new(host, options)
  end
  
  def environment_id
    CGI.escape [ Conjur::Config[:namespace], 'secrets' ].join('/')
  end
  
  def environment_path
    [ 'environments', environment_id ].join '/'
  end
  
  def login_as(login)
    @token = authorization_token(login)
  end
  
  def authorization_token(login)
    require 'conjur/api'
    api = Conjur::API.new_from_key(['host', Conjur::Config[:namespace], login ].join('/'), api_key(login))
    token = api.token
    "Token token=\"#{Base64.strict_encode64 token.to_json}\""
  end
  
  def api_key(login)
    key = [ Conjur::Config[:account], 'host', [ Conjur::Config[:namespace], login ].join('/') ].join(':')
    Conjur::Config[:api_keys][key] or raise "User #{key} not found in #{Conjur::Config[:api_keys].keys}"
  end
end

World(SecretsManagementWorld, RSpec::Expectations, RSpec::Matchers)
