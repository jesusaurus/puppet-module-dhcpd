# Define: dhcpd::subnet
#
# This resource describes a dhcp subnet block.
#
# Parameters:
#   [*sharednet*]
#     The name of the dhcpd::sharednet resource this subnet belongs in.
#
#   [*network*]
#     The IP address of the subnet.
#
#   [*netmask*]
#     The netmask for the subnet.
#
#   [*router*]
#     The IP of the default route.
#
#   [*dns*]
#     An array of DNS servers.
#
# Actions:
#   Create a subnet block within the specified shared network block.
#
# Requires:
#   Class['concat']
#   Class['dhcpd']
#
define dhcpd::subnet (
  $sharednet,
  $network = '10.0.0.1',
  $netmask = '255.0.0.0',
  $router  = '10.0.0.1',
  $dns     = [ '8.8.8.8' ],
) {

  concat::fragment { "dhcpd_subnet_$name":
    target  => "/etc/dhcp/dhcpd.conf.d/sharednet.$sharednet",
    content => template('dhcpd/etc/dhcpd.subnet.erb'),
    order   => 0100,
  }

  concat { "/etc/dhcp/dhcpd.conf.d/subnet.$name":
    notify => Service[$::dhcpd::service],
  }

  concat::fragment { "dhcpd_subnet_${name}_head":
    target  => "/etc/dhcp/dhcpd.conf.d/subnet.$name",
    content => template('dhcpd/etc/dhcpd.subnet.head.erb'),
    order   => 0001,
  }

  concat::fragment { "dhcpd_subnet_${name}_foot":
    target  => "/etc/dhcp/dhcpd.conf.d/subnet.$name",
    content => template('dhcpd/etc/dhcpd.subnet.foot.erb'),
    order   => 9001,
  }

}
