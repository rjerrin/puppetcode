class profile::services::vm( Hash $client = lookup('virtualbox', { value_type => Hash })) {
class { 'virtualbox':
  version => $client['version'],
}


}

