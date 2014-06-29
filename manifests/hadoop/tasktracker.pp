# Setting up tasktracker
class mesos::hadoop::tasktracker {

  Class['mesos::hadoop::hdfs'] ->

  package{'hadoop-0.20-mapreduce-tasktracker':
    ensure  => present
  } ->

  service{'hadoop-0.20-mapreduce-tasktracker':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

}
