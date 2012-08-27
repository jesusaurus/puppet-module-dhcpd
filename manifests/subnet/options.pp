# Define: dhcpd::subnet::options
#
# This resource describes a dhcp subnet block.
#
# Parameters:
#   [*subnet*]
#     The name of the dhcpd::subnet resource these options belong in.
#
#   [*source*]
#     The IP of the default route.
#
#   [*content*]
#     An array of DNS servers.
#
# Actions:
#   Create a concat::fragment from the specified source or content
#   describing a raw block of options for a subnet.
#
# Requires:
#   Class['concat']
#   Class['dhcpd']
#
define dhcpd::subnet::options (
  $subnet,
  $source  = '',
  $content = '',
) {

  case $content {
    '': {
      case $source {
        '': {
          case $ensure {
            '', 'absent', 'present', 'file', 'directory': {
              crit('No content, source or symlink specified')
            }
          }
        }
        default: { Concat::Fragment{ source => $source } }
      }
    }
    default: { Concat::Fragment{ content => $content } }
  }

  concat::fragment { "dhcpd_subnet_options_$name":
    target => "/etc/dhcp/dhcpd.conf.d/subnet.$subnet",
    order  => 0050,
  }

}
