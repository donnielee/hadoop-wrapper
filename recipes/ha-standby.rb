#
# Cookbook Name:: skt-hadoop
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'hadoop::default'
include_recipe 'hadoop::hadoop_hdfs_namenode'
include_recipe 'hadoop::hadoop_hdfs_zkfc'


# Execute namenode related jobs
#

#ruby_block 'hdfs-namenode-bootstrap-standby' do
#  block do
#    resources(execute: 'hdfs-namenode-bootstrap-standby').run_action(:run)
#  end 
#end

ruby_block 'hdfs-namenode-bootstrap-standby' do
  block do
    resources(execute: 'hdfs-namenode-bootstrap-standby').run_action(:run)
  end 
end

ruby_block 'service-hadoop-hdfs-namenode-start-and-enable' do
  block do
    %w(enable start).each do |action|
      resources('service[hadoop-hdfs-namenode]').run_action(action.to_sym)
    end
  end
end


# Initializing HA state in Zookeeper <- HDFS High Availability
#
# Initializing HA state in Zookeeper <- HDFS High Availability
#

ruby_block 'service-hadoop-hdfs-zkfc-start-and-enable' do
  block do
    %w(enable start).each do |action|
      resources('service[hadoop-hdfs-zkfc]').run_action(action.to_sym)
    end
  end
end
