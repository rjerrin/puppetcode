class profile::services::upgrade () {
include apt

cron { 'upgrade':

     command => 'apt-get  dist-upgrade',
     user    => 'root',
     hour    => 8,
     minute  => 10,

}

$upgrade_blacklist = hiera_array('held')
class {'unattended_upgrades':
  legacy_origin => false,
  origins => [],
  upgradeable_packages => { 'debdelta' => 1, },	
    }
  
}
