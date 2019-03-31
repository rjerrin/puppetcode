class profile::services::upgrade () {
cron { 'upgrade':
  command => 'apt-get -y dist-upgrade',
  user    => 'root',
  hour    => 8,
  minute  => 10,
}
}
