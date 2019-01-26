class profile::services::ubase (
  Array $eservices = lookup('eservices', {value_type => Array}),
  Hash  $net  =      lookup('networking', { value_type => Hash } ),
  Array $ns  = lookup('nameservers', { value_type => Array }),
  Hash  $sysctl = lookup('sysctl',  { value_type => Hash } ),
  Array $commands = lookup('commands', {value_type => Array}),
  Array $packages = lookup('packages', {value_type => Array, default_value => [] }),
  Array $ipackages = lookup('ipackages', {value_type => Array, default_value => [] }),
  Hash  $files  = lookup('files',  { value_type => Hash, default_value => {} } ),
  Hash  $fcontent  = lookup('fcontent',  { value_type => Hash, default_value => {} } ),
)
{

  if $facts['os']['family'] == 'Debian' {
    $eservices.each | String $service| {
      service { "${service}":
        ensure => stopped,
        enable => false,
        
      }

    }

    $ipackages.each | String $pkg | {
      package { $pkg:
        name => $pkg,
        ensure => present,
        

      }
    }
    include  'profile::services::upgrade'
    include  'profile::services::time'	
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


$packages.each | String $package | {
  package { $package:
    name => $package,
    ensure => absent,
  }
}

$files.each | String $path, String $ftype | {
  file { "${path}":
    path  =>  $path,
    ensure => $ftype,
    owner  => 'root',
    mode  => '755',
    
  }
  
}

$fcontent.each | String $path, String $content | {
  file_line { 'fcontent':
    ensure => present,
    path   => $path,
    line   => $content,
    match  => "^${content}",
  }
  
}

}
  


 


        
       
