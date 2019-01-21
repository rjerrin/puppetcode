class  profile::services::nfsshare (
         Hash $client = lookup('nfsshare', { value_type => Hash }),
       )
{
  class { '::nfs':
            server_enabled => true
}
            
    nfs::server::export{ $client['share']:
    ensure  => 'mounted',
    clients => $client['access'],
 }

 
}
