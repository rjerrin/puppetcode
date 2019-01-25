class profile::services::time() {

  class { "ntp":
    servers    => [ '0.asia.pool.ntp.org', '0.asia.pool.ntp.org', '0.asia.pool.ntp.org',  '1.asia.pool.ntp.org'],
  }

  
}
