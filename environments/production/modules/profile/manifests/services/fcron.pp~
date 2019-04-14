class profile::services::upgrade () {


cron { 'upgrade':

     command => 'apt-get  dist-upgrade',
     user    => 'root',
     hour    => 8,
     minute  => 10,

}

$upgrade_blacklist = hiera_array('held')
class {'::unattended_upgrades':
  period    => '1',
  repos     => {
    },
   blacklist => $upgrade_blacklist,
}




}
