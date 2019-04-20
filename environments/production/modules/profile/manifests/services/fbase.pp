class profile::services::fbase (
    Array $ipackages =   lookup('ipackages', {value_type => Array, default_value => [] }),
    Array $rcconf  =  lookup('rcconf',  { value_type => Array, default_value => [] } ),
    Array $loaderconf  = lookup('loaderconf',  { value_type => Array, default_value => [] } ),		
    Array $services =    lookup('services', {value_type => Array}),
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


$rcconf.each |  String $content | {
  file_line { $content :
    ensure => present,
    path   => "/etc/rc.conf",
    line   => $content,
    match  => "^${content}",
  }
  
}


$loaderconf.each |  String $content | {
  file_line { $content :
    ensure => present,
    path   => "/boot/loader.conf",
    line   => $content,
    match  => "^${content}",
  }

}

}

