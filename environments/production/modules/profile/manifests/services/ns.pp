class profile::services::ns (  Array $ns  = lookup('nameservers', { value_type => Array, default_value => [] }),) {

class { 'resolv_conf':
  nameservers =>  $ns,
}

}