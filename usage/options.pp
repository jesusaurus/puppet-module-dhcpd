# Expand the simple example usage of the dhcpd class to do pxe.
#
# This gives out class A addresses in the range 10.0.10.0 - 10.0.10.254,
# with a default route through 10.0.0.10, a domain name server 8.8.8.8,
# and a pxe server at 10.0.0.1 with the image 'pxelinux.0'.

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

  dhcpd::subnet::options { 'pxeboot':
    subnet  => 'hello',
    content => '
      filename "pxelinux.0";
      next-server 10.0.0.1;
    ',
  }

  dhpcd::pool { 'world':
    subnet => 'hello',
    range  => '10.0.10.1 10.0.10.254',
  }

}
