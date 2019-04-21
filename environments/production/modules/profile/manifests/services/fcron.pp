class profile::services::fcron () {


cron { 'upgrade':
     command => '/usr/sbin/pkg upgrade -y',
     user    => 'root',
     hour    => 9,
     minute  => 10,

}

cron { 'freebsd-update':
     command => '/usr/sbin/freebsd-update fetch && /usr/sbin/freebsd-update install',
     user    => 'root',
     hour    => 10,
     minute  => 10,

}

cron { 'puppet-agent':
  command => '/usr/local/bin/puppet agent -t -v --server puppet',
  user    => 'root',
  hour    => ['0-23'],
  minute  => '*/30',
}




     

}
