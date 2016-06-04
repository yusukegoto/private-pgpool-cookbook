#
# Cookbook Name:: pgpool
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'pgpool::postgres95'

package 'pgpool-II-95'

%w(pgpool.conf pool_hba.conf).each do |pool_conf|
  template "/etc/pgpool-II-95/#{pool_conf}" do
    notifies :reload, 'service[pgpool-II-95]'
  end
end

service 'pgpool-II-95' do
  supports enable: true, start: true, stop: true, restart: true, reload: true
  action [:enable, :start]
end
