# Chef Resoruces
service "apache2" do
    supports :restart => true, :reload => true
    action :enable
end

# Template
template "/tmp/test.conf" do
    mode "644"
    source "test.conf.erb"
    variables :test_var => 'test variable '
    notifies :restart, "service[apache2]"
    #action :create
end

# Chef Resrouces
begin
	http_request "some message" do
	  action :get
	  url "http://www.nttmcl.com/"
	  message :some => "data"
	end
rescue
    Chef::Log.error "Fail HTTP"
end

if platform?("debian","ubuntu")
    # File
    cookbook_file "/tmp/vimrc" do
        source "vimrc"
        mode 0755
        owner "root"
        group "root"
    end
end

# Library Test
class Chef::Recipe
  include Core
end
core_func do |c|
    # Definitions Test
    test_site "my_site.conf" do
        enable true
        filename "test" + c.to_s()
    end
end

# Package Install
package "mysql-server" do
    action :install
end

# Custom Provider/Resrouces Sample
testcookbook_database "djangodb" do
    type "innodb"
    action :create
    provider "testcookbook_mysql"
end 
