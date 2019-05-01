# setup variables for different distributions
class tor::daemon::params {
  case $facts['osfamily'] {
    'RedHat': {
      $user          = 'toranon'
      $group         = 'toranon'
      $manage_user   = false
      $data_dir_mode = '0750'
      $config_file   = '/etc/tor/torrc'
    }
    'Debian': {
      $user          = 'debian-tor'
      $group         = 'debian-tor'
      $manage_user   = true
      $data_dir_mode = '0700'
      $config_file  = '/etc/tor/torrc'

    }

   'FreeBSD':
     {
       $user =  '_tor'
       $group = '_tor'
       $manage_user = true
       $data_dir_mode = '0700'

     }
    default: { fail("No support for osfamily ${facts['osfamily']}") }
  }

}
