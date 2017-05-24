#
# Cookbook Name:: skt_hadoop
# Attribute:: default
#
# Copyright © 2013-2016 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



# Hadoop
default['hadoop']['distribution'] = 'bigtop'
default['hadoop']['force_format'] = true
default['hadoop']['distribution_version'] = '1.2.0'

# core-site.xml settings
###
default['hadoop']['core_site']['fs.defaultFS'] = 'hdfs://gpu-cluster'
default['hadoop']['hdfs_site']['fs.defaultFS'] = 'hdfs://gpu-cluster'

###
# yarn-site.xml settings
###
default['hadoop']['yarn_site']['yarn.resourcemanager.hostname'] = "d-ttro-os12"

###
# HA settings
###
default['hadoop']['hdfs_site']['dfs.nameservices'] = "gpu-cluster"
default['hadoop']['hdfs_site']['dfs.ha.namenodes.gpu-cluster'] = "namenode139,namenode171"


default['hadoop']['hdfs_site']['dfs.namenode.rpc-address.gpu-cluster.namenode139'] = 'd-ttro-os15:9820'
default['hadoop']['hdfs_site']['dfs.namenode.rpc-address.gpu-cluster.namenode171'] = 'd-ttro-os16:9820'
default['hadoop']['hdfs_site']['dfs.namenode.http-address.gpu-cluster.namenode139'] = 'd-ttro-os15:9870'
default['hadoop']['hdfs_site']['dfs.namenode.http-address.gpu-cluster.namenode171'] = 'd-ttro-os16:9870'



default['hadoop']['hdfs_site']['dfs.client.failover.proxy.provider.gpu-cluster'] = 'org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider'
default['hadoop']['hdfs_site']['dfs.namenode.shared.edits.dir'] = 'file:///mnt/nfsshare'
# sshfence([[username][:port]])
default['hadoop']['hdfs_site']['dfs.ha.fencing.methods'] = 'sshfence'
default['hadoop']['hdfs_site']['dfs.ha.fencing.ssh.private-key-files'] = '/home/hdfs/.ssh/id_rsa'

###
# Zookeeper settings
###
default['hadoop']['hdfs_site']['dfs.ha.automatic-failover.enabled'] = 'true'
default['hadoop']['core_site']['ha.zookeeper.quorum'] = "d-ttro-os14:2181"
default['hadoop']['core_site']['ha.zookeeper.quorum'] = "d-ttro-os15:2181"
default['hadoop']['core_site']['ha.zookeeper.quorum'] = "d-ttro-os16:2181"

#
# haddop cookbook의 attributes/default.rb에 정의되어 있지 않은 zoo.cfg파일 파라미터
default['zookeeper']['zoocfg']['initLimit']="10"
default['zookeeper']['zoocfg']['syncLimit']="5"
default['zookeeper']['zoocfg']['tickTime']="200"

default['zookeeper']['zoocfg']['server.1']="d-ttro-os14:2888:3888"
default['zookeeper']['zoocfg']['server.2']="d-ttro-os15:2888:3888"
default['zookeeper']['zoocfg']['server.3']="d-ttro-os16:2888:3888"

#journal node setting
default['hadoop']['hdfs_site']['dfs.journalnode.edits.dir'] = '/usr/lib/hadoop-jn'
