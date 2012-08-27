# Define: dhcpd::classdef
#
# This resource describes a dhcp class block
#
# Parameters:
#   [*body*]
#     Literal body of the class definition, the contents of
#     this variable will be put between the braces of a class
#     definition.
#
# Actions:
#   Create a class definition of the same name in the file
#   /etc/dhcp/dhcpd.conf.d/classes
#
# Requires:
#   Class['concat']
#   Class['dhcpd']
#
define dhcpd::classdef (
  $body,
) {

  concat::fragment { "dhpcd_class_$name":
    target  => "/etc/dhcp/dhcpd.conf.d/classes",
    content => template('dhcpd/etc/dhcpd.class.erb'),
  }

}
