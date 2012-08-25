define dhcpd::subnet (
  $sharednet,
  $network = '10.0.0.1',
  $netmask = '255.0.0.0',
  $dns     = [ '8.8.8.8' ],
  $routers = [ '10.0.0.1' ],
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
