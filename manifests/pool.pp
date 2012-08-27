# Define: dhcpd::pool
#
# This resource describes a dhcp pool definition.
#
# Parameters:
#   [*subnet*]
#     The name of the dhcpd::subnet resource this pool belongs in.
#
#   [*deny*]
#     An array of strings. A match against any item will prevent
#     this pool being used.
#
#   [*allow*]
#     An array of strings. A match against any item will ensure
#     this pool being used.
#
#   [*range*]
#     A string containing two IPs separated by a space. Offers from
#     this pool will contain an IP between the two specified.
#
#   [*default_lease*]
#     An integer representing the default number of seconds until
#     a dhcp lease expires.
#
#   [*max_lease*]
#     An integer representing the maximum number of seconds until
#     a dhcp lease expires.
#
# Actions:
#   Create a pool definition within the specified subnet definition.
#
# Requires:
#   Class['concat']
#   Class['dhcpd']
#
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
