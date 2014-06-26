# installing mesos deb and egg for both slave and master
class mesos::install {
  ensure_packages(['python-setuptools', 'python-protobuf'])

  ensure_packages(['default-jre', 'zookeeperd'])
  Package['default-jre'] ->  Package['zookeeperd']

  $version = '0.19.0'
  $url  = 'http://downloads.mesosphere.io/master/ubuntu/14.04'

  $deb  = "mesos_${version}~ubuntu14.04+1_amd64.deb"
  $download = regsubst($deb,'\+', '%2B')

  exec{'download mesos deb':
    command => "wget -P /usr/src ${url}/${download}",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    creates => "/usr/src/${deb}",
    tries   => 3,
    timeout => 600
  } ->

  exec{'install mesos deb':
    command => "dpkg -i /usr/src/${deb}",
    user    => 'root',
    path    => ['/usr/bin','/bin','/sbin'],
    require => Package['default-jre', 'zookeeperd']
  }

  $egg = "mesos-${version}_rc2-py2.7-linux-x86_64.egg "

  exec{'download mesos egg':
    command => "wget -P /tmp ${url}/${egg}",
    user    => 'root',
    path    => ['/usr/bin','/bin','/sbin'],
    creates => "/usr/src/${egg}",
    tries   => 3,
    timeout => 600
  } ->

  exec{'install mesos egg':
    command => "easy_install /tmp/${egg}",
    user    => 'root',
    path    => '/usr/bin',
    require => Package['python-setuptools', 'python-protobuf']
  }

}
