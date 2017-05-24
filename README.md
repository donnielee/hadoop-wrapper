# skt-hadoop Cookbook

hadoop cookbook을 이용하여 hadoop HA(High Availability)를 구축할 수 있도록 하는 wrapper cookbook입니다.


## Requirements

namenode 서버 2대이상, zookeeper 3대이상, nfs 또는 journal manager


### Platforms

- CentOS 7.2에서 시험 완료

### Chef

- Chef 12.0 or later

### Cookbooks



## Attributes

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

## Usage

### skt-hadoop::default

사용하려는 recipe를 node의 run list에 포함하여 사용

e.g.
예를 들어, 특정 서버에 namenode, zookeeper, nfs를 설치하려면
hosts cookbook을 설치하여, hadoop cluster 서버들의 hostname 및 IP Address를 cluster 서버들의 /etc/hosts에 저장하고,
zookeeper를 설치하여, namenode와 함께 설치되는 zkfc(zookeeper failover controller)가 연동될 수 있도록 한다.
그리고 나서, ative 및 standby namenode가 metadata 변경사항을 기록할 nfs 서버 또는 journal manager를 설치하고,
hadoop namenode ha active를 설치한 후 standby를 설치한다.

이외에, data node, node manager, resource manager도 cluster의 환경에 맞게 설치할 수 있도록 한다.


## Contributing


## License and Authors

Authors: SK텔레콤 SDI Lab TODO: List authors

# hadoop-wrapper
