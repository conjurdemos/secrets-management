module SecretsManagementWorld
  def rest_resource(login)
    options = { headers: { authorization: @token } }
    host = Conjur::Core::API.host
    RestClient::Resource.new(host, options)
  end
  
  def environment_id
    CGI.escape [ $config[:namespace], 'secrets' ].join('/')
  end
  
  def environment_path
    [ 'environments', environment_id ].join '/'
  end
  
  def login_as(login)
    @token = authorization_token(login)
  end
  
  def authorization_token(login)
    require 'conjur/api'
    api = Conjur::API.new_from_key(['host', $config[:namespace], login ].join('/'), api_key(login))
    token = api.token
    "Token token=\"#{Base64.strict_encode64 token.to_json}\""
  end
  
  def api_key(login)
    env_key = "#{login.upcase}_API_KEY"
    $config[:api_keys][login.to_sym] or raise "No env_key"
  end
end

World(SecretsManagementWorld, RSpec::Expectations, RSpec::Matchers)
