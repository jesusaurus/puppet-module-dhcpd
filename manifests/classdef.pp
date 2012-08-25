define dhcpd::classdef (
  $body,
) {

  concat::fragment { "dhpcd_class_$name":
    target  => "/etc/dhcp/dhcpd.conf.d/classes",
    content => template('dhcpd/etc/dhcpd.class.erb'),
  }

}
