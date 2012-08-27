# Example usage of the dhcpd class with exported host definitions

# Hosts which have successfully run puppet will move into a pool
#  of addresses with a longer lease time.

node 'server' {
  include local::dhcp::server
}

node default {
  include local::dhcp::client
}

class local::dhcp::server {

  class { '::dhcpd':
    domain => 'localdomain',
  }

  dhcpd::sharednet { 'everyone': }

  dhcpd::subnet { 'tenNet':
    sharednet => 'everyone',
    network   => '172.24.0.0',
    netmask   => '255.255.0.0',
    dns       => '172.24.24.24',
    router    => '172.24.0.1',
  }

  dhcpd::pool { 'known':
    subnet  => 'tenNet',
    range   => '172.24.10.1 172.24.10.254',
    deny    => 'unknown-clients',
  }

  dhcpd::pool { 'unknown':
    subnet  => 'tenNet',
    range   => '172.24.100.1 172.24.100.254',
    allow   => 'unknown-clients',
    default_lease => 28880,
  }

  Dhpcd::Host <<| |>>

}

class local::dhcp::client {
  @@dhcpd::host { $::fqdn:
    mac => $::macaddress,
  }
}
