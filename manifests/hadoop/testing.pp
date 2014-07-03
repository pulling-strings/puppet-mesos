# misc testing utilities see
class mesos::hadoop::testing {
  file { '/usr/local/bin/sample-runjob.sh':
    ensure=> file,
    mode  => 'a+x',
    source=> 'puppet:///modules/mesos/runjob.sh',
    owner => root,
    group => root,
  }

  file { '/usr/local/bin/sample-cleanup.sh':
    ensure=> file,
    mode  => 'a+x',
    source=> 'puppet:///modules/mesos/cleanup.sh',
    owner => root,
    group => root,
  }
}
