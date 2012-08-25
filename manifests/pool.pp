define dhcpd::pool (
  $subnet,
  $deny          = [],
  $allow         = [],
  $range         = '10.0.0.1 10.0.0.254',
  $default_lease = 2400,
  $max_lease     = 7200,
) {

  concat::fragment { "dhcpd_pool_$name":
    target  => "/etc/dhcp/dhcpd.conf.d/subnet.$subnet",
    content => template("dhcpd/etc/dhcpd.pool.erb"),
    order   => 0100,
  }

}
