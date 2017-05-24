#
# Cookbook Name:: skt-hadoop
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'hadoop::default'
include_recipe 'hadoop::hadoop_hdfs_journalnode'


#zkfc
ruby_block 'service-hadoop-hdfs-journalnode-start-and-enable' do
  block do
    %w(enable start).each do |action|
      resources('service[hadoop-hdfs-journalnode]').run_action(action.to_sym)
    end
  end
end
