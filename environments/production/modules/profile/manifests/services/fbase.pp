class profile::services::fbase (
    Array $ipackages = lookup('ipackages', {value_type => Array, default_value => [] }),
    Array $facontent  = lookup('facontent',  { value_type => Array, default_value => [] } ),
    Array $services = lookup('services', {value_type => Array}),
){

include profile::services::time
include profile::services::fcron
include profile::services::ns
include pf

    $ipackages.each | String $pkg | {
      package { $pkg:
        name => $pkg,
        ensure => latest,
        
}

}


$services.each | String $service| {
      service { "${service}":
        ensure => running,
        enable => true,
        
      }

    }


$facontent.each |  String $content | {
  if ! defined {
  file_line { "/etc/rc.conf" :
    ensure => present,
    path   => "/etc/rc.conf",
    line   => $content,
    match  => "^${content}",
  }
}
  
}



}

