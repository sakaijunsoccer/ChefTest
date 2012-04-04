#require_recipe "apache2"

# Update repository
case node[:platform]
    when "debian","ubuntu"
        e = execute "apt-get update" do
          ignore_failure true
          action :nothing
        end
        e.run_action(:run)
end

# Install apache2
package "apache2" do
  case node[:platform]
  when "centos","redhat","fedora","suse"
    package_name "httpd"
  when "debian","ubuntu"
    package_name "apache2"
  end
  action :install
end

# Install mysql server
package "mysql-server" do
    action :install
end

# Install Postgres
include_recipe "postgresql::server"
include_recipe "database"

postgresql_connection_info = {:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']}

# Create django db on postgres
database 'django' do
  connection postgresql_connection_info
  provider Chef::Provider::Database::Postgresql
  action :create
end

# Resoruces sample
service "apache2" do
    supports :restart => true, :reload => true
    action :enable
end

# Template sample
template "/tmp/test.conf" do
    mode "644"
    source "test.conf.erb"
    variables :test_var => 'test variable '
    notifies :restart, "service[apache2]"
    #action :create
end

# Log Test
begin
  raise "error message"
rescue => e
  Chef::Log.error "ERROR: %s" % e
end

# Resrouces http request sample
http_request "some message" do
  action :get
  ignore_failure true
  url "http://www.nttmcl.com/"
  message :some => "data"
end

# Attribute sample
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
