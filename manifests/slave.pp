# setting up mesos slave
class mesos::slave {

  include mesos::install

  service{'zookeeper':
    ensure    => stopped,
    enable    => false,
    hasstatus => true,
    require   => Class['mesos::install']
  }

  service{'mesos-master':
    ensure    => stopped,
    enable    => false,
    hasstatus => true,
    require   => Class['mesos::install']
  } ->

  service{'mesos-slave':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Class['mesos::install']
  }
}
