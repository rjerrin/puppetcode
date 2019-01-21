class profile::services::ubase (
  Array $eservices = lookup('eservices', {value_type => Array}),
  Hash  $net  =      lookup('networking', { value_type => Hash } ),
  Array $ns  = lookup('nameservers', { value_type => Array }),
  Hash  $sysctl = lookup('sysctl',  { value_type => Hash } ),
  Array $commands = lookup('commands', {value_type => Array}),
  )	     {
  
  include '::network'
  case $facts['os']['name'] {
    'Debian', 'Ubuntu':  { include 'apt' include 'unattended_upgrades' }
  }


  if $facts['os']['family'] == 'Debian' {
    $eservices.each | String $service| {
      service { "${service}":
        ensure => stopped,
        enable => false,
        
      }
    }
  }
  network_config { $net['interface'] :
    ensure    => present,
    family    => 'inet',
    ipaddress => $net['IP'],
    method    => 'static',
    netmask   => $net['netmask'],
    onboot    => true,
  }
  
  network_route { 'default':
    ensure    => present,
    gateway   => $net['gateway'],
    netmask   => '0.0.0.0',
    network   => 'default'
  }

  if  $facts['os']['name'] == 'Debian'  {
   
    $commands.each  | String $cmd |  {
    exec { "${cmd}":
      path => ['/sbin','/usr/bin', '/home/jery',],
      user => 'root',
      

    }
    
    }
  }
  

  class { 'resolv_conf':
    nameservers =>  $ns,
  }
                     

  $sysctl.each | String $sysvar, String $value | {
    sysctl { $sysvar:
      ensure => present,
      value =>  $value,
    }

  }
  

  }


        
       
