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
