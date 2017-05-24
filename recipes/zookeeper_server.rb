#
# Cookbook Name:: skt-hadoop
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'hadoop::default'
include_recipe 'hadoop::zookeeper_server'


# Execute namenode related jobs
#

#ruby_block 'hdfs-namenode-bootstrap-standby' do
#  block do
#    resources(execute: 'hdfs-namenode-bootstrap-standby').run_action(:run)
#  end 
#end

ruby_block 'service-zookeeper-server-start-and-enable' do
  block do
    %w(enable start).each do |action|
      resources('service[zookeeper-server]').run_action(action.to_sym)
    end
  end
end


