#
# Cookbook Name:: skt-hadoop
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'hadoop::default'
include_recipe 'hadoop::hadoop_yarn_resourcemanager'

# Execute resourcemanager related jobs
#
ruby_block 'hdfs-tmpdir' do
  block do
    resources(execute: 'hdfs-tmpdir').run_action(:run)
  end 
end

ruby_block 'yarn-remote-app-log-dir' do
  block do
    resources(execute: 'yarn-remote-app-log-dir').run_action(:run)
  end 
end

ruby_block 'yarn-app-mapreduce-am-staging-dir' do
  block do
    resources(execute: 'yarn-app-mapreduce-am-staging-dir').run_action(:run)
  end 
end

ruby_block 'service-hadoop-yarn-resourcemanager-start-and-enable' do
  block do
    %w(enable start).each do |action|
      resources('service[hadoop-yarn-resourcemanager]').run_action(action.to_sym)
    end
  end
end


