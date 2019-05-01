# manage polipo resources
class tor::polipo::base {
  package{'polipo':
    ensure => present,
  }

  if $facts['osfamily'] == 'Debian' {
    $polipo_config = "/etc/polipo/config"
    $owner = 'root'
    $group = 'root'
  }
  elsif $facts['osfamily'] == 'FreeBSD' {
    $polipo_config = "/usr/local/etc/polipo/config"
    $owner = 'root'
    $group = 'wheel'
    file { '/var/log/polipo':
      ensure  => present,
      owner   => polipo,
      group   => polipo,
  }

  }

  file {  "${polipo_config}":
    ensure  => present,
    owner   => "${owner}",
    group   => "${group}",
    mode    => '0644',
    source  => 'puppet:///modules/tor/polipo/polipo.conf',
    require => Package['polipo'],
    notify  => Service['polipo'],
  }


  service { 'polipo':

    ensure  => running,
    enable  => true,
    require => [ Package['polipo'], Service['tor'] ],
  }
}
