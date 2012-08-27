# Define: dhcpd::host
#
# This resource describes a dhcp host definition.
#
# Parameters:
#   [*mac*]
#     The hardware address of the host.
#
# Actions:
#   Create a host definition of the same name in the file
#   /etc/dhcp/dhcpd.conf.d/hosts
#
# Requires:
#   Class['concat']
#   Class['dhcpd']
#
define dhcpd::host (
  $mac,
) {

  concat::fragment { "dhcpd_host_$name":
    target  => "/etc/dhcp/dhcpd.conf.d/hosts",
    content => template('dhcpd/etc/dhcpd.host.erb'),
  }

}
