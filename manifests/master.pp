# setting up mesos master
class mesos::master {

  include mesos::install

  service{'zookeeper':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Class['mesos::install']
  } ->

  service{'mesos-master':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Class['mesos::install']
  }

}
