define :test_site, :enable => true do
  if params[:enable]
    template "/tmp/#{params[:filename]}.txt" do
    source "my_site.conf.erb"
    mode 0644
    end
  end
end
