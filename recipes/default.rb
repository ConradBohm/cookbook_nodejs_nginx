#
# Cookbook:: node_sample
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.


include_recipe 'nodejs'
include_recipe 'apt'

# node['nodejs']['npm']['apt']


apt_update 'update_sources' do
  action :update
end

package 'nginx'
package 'npm'

# resource service
service 'nginx' do
  action([:start, :enable])
end

nodejs_npm 'pm2'

# resource template
template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  notifies :restart, 'service[nginx]'
end

# resource link
link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end
