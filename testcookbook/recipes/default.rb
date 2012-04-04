e = execute "apt-get update" do
  action :nothing
end

e.run_action(:run)

package "apache2" do
  case node[:platform]
  when "centos","redhat","fedora","suse"
    package_name "httpd"
  when "debian","ubuntu"
    package_name "apache2"
  end
  action :install
end

# Package Install
package "mysql-server" do
    action :install
end

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

# Log Test
#begin
#  raise "error message"
#rescue => e
#  Chef::Log.error "ERROR: %s" % e
#end

# Chef Resrouces
http_request "some message" do
  action :get
  url "http://www.nttmcl.com/"
  message :some => "data"
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


# Custom Provider/Resrouces Sample
testcookbook_database "djangodb" do
    type "innodb"
    action :create
    provider "testcookbook_mysql"
end 
