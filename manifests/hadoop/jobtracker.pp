# Setting up Mrv1 jobtracker
class mesos::hadoop::jobtracker {

  $dest = '/usr/lib/hadoop-0.20-mapreduce/lib'
  $jar = 'hadoop-mesos-0.0.8.jar'

  Class['mesos::hadoop::hdfs'] ->

  package{'hadoop-0.20-mapreduce-jobtracker':
    ensure  => present
  } ->

  exec{'download mesos-hadoop jar':
    command => "wget -P ${dest}/ http://dl.bintray.com/narkisr/narkisr-jars/",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    creates => "${dest}/${jar}"
  } ->

  service{'hadoop-0.20-mapreduce-jobtracker':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }


}
