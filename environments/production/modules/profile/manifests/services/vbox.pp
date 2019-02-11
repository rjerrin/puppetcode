class profile::services::vbox(
  Hash $vms = lookup('vms', { value_type => Hash, default_value =>{} } ),
){
$vms.each | String  $vm, String $usr |  {
  exec { "${vm}":
    user =>  $usr,
    path =>  [ '/bin', '/usr/bin', '/sbin', '/usr/sbin' ],
    unless => "pgrep  \"VboxManage startvm --type gui \"${vm}\" \" ",
  }

}

}








    
    
