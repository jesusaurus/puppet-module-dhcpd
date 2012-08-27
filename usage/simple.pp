# Simple example usage of the dhcpd class
#
# This gives out class A addresses in the range 10.0.10.0 - 10.0.10.254,
# with a default route through 10.0.0.10 and domain name server 8.8.8.8

class local::dhcpserver {

  class { dhcpd:
    domain => 'example.com',
  }

  dhcpd::sharednet { 'example.com': }

  dhcpd::subnet { 'hello':
    sharednet => 'example.com',
    network   => '10.0.0.0',
    netmask   => '255.0.0.0',
    dns       => [ '8.8.8.8', ]
    router    => '10.0.0.10',
  }

  dhpcd::pool { 'world':
    subnet => 'hello',
    range  => '10.0.10.1 10.0.10.254',
  }

}
