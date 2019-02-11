class profile::services::upgrade () {
cron { 'upgrade':
  command => 'apt-get -y  update  && apt-get -y dist-upgrade',
  user    => 'root',
  hour    => 18,
  minute  => 35,
}
}
