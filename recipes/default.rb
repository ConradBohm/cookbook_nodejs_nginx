#
# Cookbook:: node_sample
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.


include_recipe 'nodejs'
include_recipe 'apt'

# node['nodejs']['npm']['apt']


apt_update 'update'
package 'nginx'
package 'npm'


service 'nginx' do
  action([:start, :enable])
end

nodejs_npm 'pm2'
