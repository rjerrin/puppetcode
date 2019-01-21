class profile::services::ubase (
        Array $eservices = lookup('eservices', {value_type => Array}),
        Hash  $net  = lookup('networking', { value_type => Hash } ),
        Hash  $sysctl = lookup('sysctl',  { value_type => Hash } ),
      )	     {

        include apt
        class 'unattended_upgrades' {
              }
          if $facts['os']['family'] == 'Ubuntu' {
              $eservices.each | String $service| {
                service { "${service}":
                ensure => stopped,
                       enable => false,
                 
                }
              }
            }
            network_config { $net['interface'] :
            ensure    => 'present',
                      family    => 'inet',
                      ipaddress => $net['IP'],
                      method    => 'static',
                      netmask   => $net['netmask'],
                      onboot    => 'true',
            }


            network_route { 'default':
            ensure    => 'present',
                      gateway   => $net['gateway'],
                      netmask   => '0.0.0.0',
                      network   => 'default'
            }
                     
      }
  

        
       
