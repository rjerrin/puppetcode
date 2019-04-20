class profile::services::debcron () {


cron { 'puppet-agent':
  command => '/usr/bin/puppet agent -t -v --server puppet',
  user    => 'root',
  hour    => ['0-23'],
  minute  => '*/30',
}






     

}
