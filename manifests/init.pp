class dhcpd (
  $domain = $::domain,
) {

  include concat::setup

  case $::osfamily {
    'RedHat': {
      $service = 'dhcpd'
    }
    'Debian': {
      $service = 'isc-dhcp-server'
    }
  }

  service { $service:
    ensure => running,
  }

  file { '/etc/dhcp/dhcpd.conf':
    ensure  => file,
    content => template('dhcpd/etc/dhcpd.conf.erb'),
    notify  => Service["$service"],
  }

  file { '/etc/dhcp/dhcpd.conf.d':
    ensure => directory,
  }

  file { '/etc/dhcp/dhcpd.conf.d/options':
    content => template('dhcpd/etc/dhcpd.options.erb'),
    notify => Service["$service"],
  }

  concat { '/etc/dhcp/dhcpd.conf.d/classes':
    notify => Service["$service"],
    force  => true, #make empty files instead of errors
  }

  concat { '/etc/dhcp/dhcpd.conf.d/sharednets':
    notify => Service["$service"],
    force  => true, #make empty files instead of errors
  }

  concat { '/etc/dhcp/dhcpd.conf.d/hosts':
    notify => Service["$service"],
    force  => true, #make empty files instead of errors
  }

}
