# basic management of resources for tor
class tor::base {
  package {'tor':
    ensure => installed,
  }

  service { 'tor':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['tor'],
  }
}
