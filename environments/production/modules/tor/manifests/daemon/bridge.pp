# Bridge definition
define tor::daemon::bridge(
  $ip,
  $port,
  $fingerprint = false ) {

  concat::fragment { "10.bridge.${name}":
    content => template('tor/torrc.bridge.erb'),
    order   => 10,
    target  => $tor::daemon::config_file,
  }
}

