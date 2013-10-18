require 'conjur/env'
config = {}
config[:env] = Conjur.env
config[:stack] = Conjur.stack
config[:account] = Conjur.account
config[:api_keys]  = {}

namespace do
  config[:namespace] = namespace
  
  managers = layer "managers"
  
  users = layer "users"
  
  environment "secrets" do
    add_member "manage_variable", managers.roleid
    add_member "use_variable",    users.roleid
  end
  
  alice, bob, claire = %w(alice bob claire).map do |hostname|
    host hostname do |h|
      config[:api_keys][hostname.to_sym] = h.attributes['api_key']
    end
  end
  
  managers.add_host alice.roleid
  users.add_host bob.roleid
end

config.to_yaml