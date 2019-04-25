class profile::services::upgrade () {

  include apt


  cron { 'upgrade':

       command => 'apt-get  dist-upgrade',
       user    => 'root',
       hour    => 8,
       minute  => 10,
}

$upgrade_blacklist = hiera_array('held')
class {	'unattended_upgrades':
   legacy_origin        => true,
   origins              => ['deb  http://mirror-1.truenetwork.ru/kali kali-rolling main non-free contrib'],
   upgradeable_packages => { 'debdelta' => 1, },	
   upgrade              => 1,
   days                 => ["0", "1", "2" ,"3" ,"4" ,"5" ,"6"],
   auto                 => { 'remove' => true }, 
   enable               => 1,
  } 
} 
