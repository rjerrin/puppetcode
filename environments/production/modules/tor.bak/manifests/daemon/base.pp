# extend basic tor things with a snippet based daemon configuration
class tor::daemon::base inherits tor::base {

  include ::tor::daemon::params

  if $tor::daemon::params::manage_user {
    group { $tor::daemon::params::group:
      ensure    => present,
      allowdupe => false,
    }

    user { $tor::daemon::params::user:
      ensure    => present,
      allowdupe => false,
      comment   => 'tor user,,,',
      home      => $tor::daemon::data_dir,
      shell     => '/bin/false',
      gid       => $tor::daemon::params::group,
      require   => Group[$tor::daemon::params::group],
    }
  }

  # directories
  file { $tor::daemon::data_dir:
    ensure  => directory,
    mode    => $tor::daemon::params::data_dir_mode,
    owner   => $tor::daemon::params::user,
    group   => 'root',
    recurse => true,
    require => Package['tor'],
  }

  file { '/usr/local/etc/tor':
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => Package['tor'],
  }

  # tor configuration file
  concat { '/usr/local/etc/tor/torrc':
    mode    => '0640',
    owner   => 'root',
    group   => $tor::daemon::params::group,
    require => Package['tor'],
    notify  => Service['tor'],
  }

  # config file headers
  concat::fragment { '00.header':
    content => template('tor/torrc.header.erb'),
    order   => '00',
    target  => '/usr/local/etc/torrc',
  }

  # global configurations
  concat::fragment { '01.global':
    content => template('tor/torrc.global.erb'),
    order   => '01',
    target  => '/usr/local/etc/tor/torrc',
  }
}
