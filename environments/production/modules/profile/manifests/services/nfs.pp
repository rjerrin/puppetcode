class  profile::services::nfsshare (
         Hash $client = lookup('nfsshare', { value_type => Hash,default_value = {} }),
       )
{
  class { '::nfs':
            server_enabled => true
}
            
    nfs::server::export{ $client['share']:
    ensure  => 'mounted',
    clients => $clients['access'],
 }

 
}
