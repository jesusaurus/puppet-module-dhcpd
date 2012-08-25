define dhcpd::host (
  $mac,
) {

  concat::fragment { "dhcpd_host_$name":
    target  => "/etc/dhcp/dhcpd.conf.d/hosts",
    content => template('dhcpd/etc/dhcpd.host.erb'),
  }

}
