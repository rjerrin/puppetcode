class profile::services::fbase (
    Array $ipackages = lookup('ipackages', {value_type => Array, default_value => [] }),
    Array $fcontent  = lookup('facontent',  { value_type => Array, default_value => [] } ),
    Array $eservices = lookup('eservices', {value_type => Array}),
){

    $ipackages.each | String $pkg | {
      package { $pkg:
        name => $pkg,
        ensure => latest,
        
}

}


$eservices.each | String $service| {
      service { "${service}":
        ensure => stopped,
        enable => false,
        
      }

    }


$fcontent.each |  String $content | {
  file_line { 'fcontent':
    ensure => present,
    path   => "/etc/rc.conf",
    line   => $content,
    match  => "^${content}",
  }
  
}



}

