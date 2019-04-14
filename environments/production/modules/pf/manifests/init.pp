class pf (
  Boolean $manage_service,
  Boolean $service_enable,
  Optional[String] $template = undef,
  Hash $template_params      = {},
  String $pfctl              = '/sbin/pfctl',
  String $tmpfile            = '/tmp/pf.conf',
  String $conf               = '/etc/pf.conf',
  String $pf_d               = '/etc/pf.d',
) {

  if $template {

    $default_params = {
      'pf_d' => $pf_d,
    }

    file { $pf_d:
      ensure  => directory,
      owner   => 'root',
      group   => '0',
      recurse => true,
      purge   => true,
    }

    concat { "${pf_d}/tables.pf":
      owner  => 'root',
      group  => '0',
      mode   => '0600',
      notify => Exec['pfctl_update'],
    }

    concat { "${pf_d}/macros.pf":
      owner  => 'root',
      group  => '0',
      mode   => '0600',
      notify => Exec['pfctl_update'],
    }

    file { $tmpfile:
      owner   => '0',
      group   => '0',
      mode    => '0600',
      content => epp($template, $default_params.merge($template_params)),
      notify  => Exec['pfctl_update'],
    }

    file { $conf:
      ensure => 'file',
      owner  => '0',
      group  => '0',
      mode   => '0600',
    }

    if $manage_service {
      $service_ensure = $service_enable ? {
        true  => 'running',
        false => 'stopped',
      }

      service { 'pf':
        ensure  => $service_ensure,
        enable  => $service_enable,
        require => File[$conf],
        before  => Exec['pfctl_update'],
      }
    }

    exec { 'pfctl_update':
      command     => "${pfctl} -nf ${tmpfile} && cp ${tmpfile} ${conf} && ${pfctl} -f ${conf}",
      unless      => "/usr/bin/diff ${tmpfile} ${conf}",
      refreshonly => true,
    }
  } else {
    warning('in order to apply PF rules, you must specify a config template')
  }
}
