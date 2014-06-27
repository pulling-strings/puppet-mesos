# setting up mesos slave
class mesos::slave($ip=false) {
  validate_string($ip)
  include mesos::install

  Class['mesos::install'] -> Service<||>
  Class['mesos::install'] -> File_line<||>
  Class['mesos::install'] -> File<||>


  service{'zookeeper':
    ensure    => stopped,
    enable    => false,
    hasstatus => true,
  } ->

  service{'mesos-master':
    ensure    => stopped,
    enable    => false,
    hasstatus => true,
  } ->

  service{'mesos-slave':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  file { '/etc/mesos/zk':
    ensure  => file,
    mode    => '0644',
    content => template('mesos/zk.erb'),
    owner   => root,
    group   => root,
  } ~> Service['mesos-slave']

}
