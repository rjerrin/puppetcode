class profile::services::ubase (
  Array $eservices = lookup('eservices', {value_type => Array, default_value => []}),
  Array $services = lookup('services', {value_type => Array, default_value => [] }),
  Hash  $net  =      lookup('networking', { value_type => Hash ,default_value => {} } ),
  Array $ns  = lookup('nameservers', { value_type => Array, default_value => [] }),
  Hash  $sysctl = lookup('sysctl',  { value_type => Hash, default_value => {}  } ),
  Array $commands = lookup('commands', {value_type => Array , default_value => [] }),
  Array $packages = lookup('packages', {value_type => Array, default_value => [] }),
  Array $ipackages = lookup('ipackages', {value_type => Array, default_value => [] }),
  Array $held = lookup('held', {value_type => Array, default_value => [] }),
  Hash  $files  = lookup('files',  { value_type => Hash, default_value => {} } ),
  Hash  $virtualbox  = lookup('enabled',  { value_type => Hash, default_value => {} } ),
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

 $services.each | String $service| {
      service { "${service}":
        ensure => running,
        enable => true,

      }

}




}

    $ipackages.each | String $pkg | {
      package { $pkg:
        name => $pkg,
        ensure => present,
        

      }
}
    $held.each | String $pkg | {
       package { $pkg:
        name => $pkg,
        ensure => held,
}
}
include  'profile::services::upgrade'
include  'profile::services::time'
include  'profile::services::scan'
include  'profile::services::debcron'

if $virtualbox['enabled'] == 'yes' {
   include 'profile::services::vbox'
}

#if  $facts['os']['lsb']['distcodename'] != 'orel' {
 
#network_config { $net['interface'] :
#  ensure    => present,
#  family    => 'inet',
#  ipaddress => $net['IP'],
#  method    => 'static',
#  netmask   => $net['netmask'],
#  onboot    => true,
#}

#}


schedule { 'puppet':
  period => hourly,
  repeat => 1,
}
  
#network_route { 'default':
#  ensure    => present,
#  gateway   => $net['gateway'],
#  netmask   => '0.0.0.0',
#  network   => 'default'
#}

#if  $facts['os']['name'] == 'Debian'  {
#  $commands.each  | String $cmd |  {
#    exec { "${cmd}":
#      path => ['/sbin','/usr/bin', '/home/jery',],
#      user => 'root',
      
#    }

#  }
#}
    
 
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
    ensure => purged,
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
  


 


        
       
