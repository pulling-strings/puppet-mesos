# setting up mesos master
class mesos::master($ip=false) {

  validate_string($ip)

  include mesos::install

  Class['mesos::install'] -> Service<||>
  Class['mesos::install'] -> File_line<||>
  Class['mesos::install'] -> File<||>

  service{'zookeeper':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  } ->

  service{'mesos-master':
    ensure    => running,
    enable    => true,
    hasstatus => true
  }

  file_line { 'master ip':
    path => '/etc/default/mesos-master',
    line => "IP=${ip}"
  } ~> Service['mesos-master']

  file { '/etc/mesos/zk':
    ensure  => file,
    mode    => '0644',
    content => template('mesos/zk.erb'),
    owner   => root,
    group   => root,
  } ~> Service['mesos-master']
}
