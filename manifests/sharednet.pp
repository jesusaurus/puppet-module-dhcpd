define dhcpd::sharednet {

  concat::fragment { "dhcpd_sharednet_$name":
    target  => "/etc/dhcp/dhcpd.conf.d/sharednets",
    content => template('dhcpd/etc/dhcpd.sharednet.erb'),
    order   => 0100,
  }

  concat { "/etc/dhcp/dhcpd.conf.d/sharednet.$name":
    notify => Service["$::dhcpd::service"],
  }

  concat::fragment { "dhcpd_sharednet_${name}_head":
    target  => "/etc/dhcp/dhcpd.conf.d/sharednet.${name}",
    content => template('dhcpd/etc/dhcpd.sharednet.head.erb'),
    order   => 0001,
  }

  concat::fragment { "dhcpd_sharednet_${name}_foot":
    target  => "/etc/dhcp/dhcpd.conf.d/sharednet.${name}",
    content => template('dhcpd/etc/dhcpd.sharednet.foot.erb'),
    order   => 9001,
  }

}
