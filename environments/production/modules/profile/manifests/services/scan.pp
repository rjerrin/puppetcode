class profile::services::scan {

  include ::rkhunter
  class {'rkhunter::cron':}


}
    
  
