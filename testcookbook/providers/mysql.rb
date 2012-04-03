action :create do
  execute "create database" do
    not_if "mysql -e 'show databases;' | grep #{new_resource.name}"
    command "mysqladmin create #{new_resource.name}"
  end
end
 
action :delete do
  execute "delete database" do
    only_if "mysql -e 'show databases;' | grep #{new_resource.name}"
    command "mysqladmin drop #{new_resource.name}"
  end
end

