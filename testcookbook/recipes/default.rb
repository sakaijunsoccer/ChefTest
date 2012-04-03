class Chef::Recipe
  include Core
end


service "apache2" do
  supports :restart => true, :reload => true
  action :enable
end

template "/tmp/test.conf" do
  mode "644"
  source "test.conf.erb"
  variables :varivari => 'testtesttesttest'
  notifies :restart, "service[apache2]"
  #action :create
end

begin
	http_request "some message" do
	  action :get
	  url "http://216.69.69.229:8080/"
	  message :some => "data"
	end
end

if platform?("debian","ubuntu")
  cookbook_file "/tmp/vimrc" do
    source "vimrc"
    mode 0755
    owner "root"
    group "root"
  end
end

core_func do |c|
  test_site "my_site.conf" do
    enable true
    filename "test" + c.to_s()
  end
end

package "mysql-server" do
  action :install
end

testcookbook_database "djangodb" do
  type "innodb"
  action :create
  provider "testcookbook_mysql"
end 





