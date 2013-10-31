namespace do
  managers = layer "managers"
  
  users = layer "users"
  
  environment "secrets" do
    add_member "manage_variable", managers.roleid
    add_member "use_variable",    users.roleid
  end
  
  alice, bob, claire = %w(alice bob claire).map do |hostname|
    host hostname  
  end
  
  managers.add_host alice.roleid
  users.add_host bob.roleid
end
