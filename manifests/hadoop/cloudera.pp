# Adding cloudera repo
class mesos::hadoop::cloudera {
  $url = 'http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh'
  apt::source { 'cloudera':
      location     => $url,
      release      => 'precise-cdh5 ',
      repos        => 'contrib',
      include_src  => false,
      architecture => 'amd64'
  } ->

  apt::key {'cloudera':
    key        => 'D1CA74A1',
    key_source => "${url}/archive.key",
  } ->

  exec{'update cloudera':
    command => 'apt-get update',
    user    => 'root',
    path    => ['/usr/bin','/bin',]
  } -> Class['cdh::hadoop']

}
