policy "secrets-management-1.1.2" do
  hosts = layer "secret-users" do
    add_host host("harry")
    add_host host("balthazar")
  end

  group "secret-managers" do
    add_member user("alice")
    
    owns do
      variable "mysql-password", mime_type: "text/plain", kind: "password" do
        permit "read",    hosts
        permit "execute", hosts
      end
    end
  end
end
