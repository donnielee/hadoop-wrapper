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


ruby_block 'hdfs-namenode-format' do
  block do
    resources(execute: 'hdfs-namenode-format').run_action(:run)
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
execute 'zkfc-format' do
  command 'hdfs zkfc -formatZK'
  action :nothing
  group 'hdfs'
  user 'hdfs'
end

ruby_block 'zkfc-format' do
  block do 
      resources(execute: 'zkfc-format').run_action(:run)
  end
end

#zkfc
ruby_block 'service-hadoop-hdfs-zkfc-start-and-enable' do
  block do
    %w(enable start).each do |action|
      resources('service[hadoop-hdfs-zkfc]').run_action(action.to_sym)
    end
  end
end
