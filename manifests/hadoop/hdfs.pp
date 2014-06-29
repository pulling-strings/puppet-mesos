# this enables hdfs test with running:
#  sudo -u hdfs hadoop fs -ls
class mesos::hadoop::hdfs(
  $name_node=false,
  $namenode_hosts=[],
  $datanode_mounts =[
    '/var/lib/hadoop/data/a',
    '/var/lib/hadoop/data/b',
    '/var/lib/hadoop/data/c'
  ],
  $dfs_name_dir = '/var/lib/hadoop/name'
) {
  include mesos::hadoop::cloudera
  include cdh::hadoop::datanode

  file{$datanode_mounts:
    ensure  => directory,
    owner   => 'hdfs',
    group   => 'hdfs',
    require => File['/var/lib/hadoop/', '/var/lib/hadoop/data']
  } -> Class['cdh::hadoop::datanode']

  file{['/var/lib/hadoop/', '/var/lib/hadoop/data']:
    ensure => directory,
    owner  => 'hdfs',
    group  => 'hdfs'
  } ->

  class { 'cdh::hadoop':
    namenode_hosts     => $namenode_hosts,
    datanode_mounts    => $datanode_mounts,
    dfs_name_dir       => $dfs_name_dir,
  }

  if($name_node){
    include cdh::hadoop::namenode
  }
}
