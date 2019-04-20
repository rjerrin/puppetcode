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



     

}
