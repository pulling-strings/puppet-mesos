# bypassing http://bit.ly/1nROQWM
class mesos::hosts($hosts=false) {
  validate_hash($hosts)

  file { '/etc/hosts':
    ensure  => file,
    mode    => '0644',
    content => template('mesos/hosts.erb'),
    owner   => root,
    group   => root,
  } ~> Service<||>
}
