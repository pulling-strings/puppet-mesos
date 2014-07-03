# Setting up Mrv1 jobtracker
class mesos::hadoop::jobtracker {

  include mesos::hadoop::patch

  Class['mesos::hadoop::hdfs'] ->

  package{'hadoop-0.20-mapreduce-jobtracker':
    ensure  => present
  } ->

  service{'hadoop-0.20-mapreduce-jobtracker':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

}
