class profile::services::time() {

  class { "ntp":
    servers    => [ '1.in.pool.ntp.org'],
  }

  
}
