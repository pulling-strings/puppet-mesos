# Adds mesos-hadoop jar and distributes patched hadoop version into hdfs
class mesos::hadoop::patch {
  $dest = '/usr/lib/hadoop-0.20-mapreduce/lib'
  $jar = 'hadoop-mesos-0.0.8.jar'
  $tar = 'hadoop-2.3.0-cdh5.0.2.tar.gz'

  exec{'put hadoop tar file':
    command => "hadoop fs -put /vagrant/${tar} /${tar}",
    user    => 'hdfs',
    path    => ['/usr/bin', '/bin'],
    unless  => "/usr/bin/hadoop fs -ls /${tar}",
    require => Service['hadoop-hdfs-datanode']
  }

  Class['mesos::hadoop::hdfs'] ->

  exec{'download mesos-hadoop jar':
    command => "cp /vagrant/${jar} ${dest} ",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    creates => "${dest}/${jar}"
  } ~> Service['hadoop-0.20-mapreduce-jobtracker']
}
