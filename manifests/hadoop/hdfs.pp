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

  file{['/var/lib/hadoop/', '/var/lib/hadoop/data']:
    ensure => directory,
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
