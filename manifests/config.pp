#
class avahi::config {

  $conf_dir                        = $::avahi::conf_dir
  $add_service_cookie              = $::avahi::add_service_cookie
  $allow_interfaces                = $::avahi::allow_interfaces
  $allow_point_to_point            = $::avahi::allow_point_to_point
  $browse_domains                  = $::avahi::browse_domains
  $cache_entries_max               = $::avahi::cache_entries_max
  $check_response_ttl              = $::avahi::check_response_ttl
  $clients_max                     = $::avahi::clients_max
  $deny_interfaces                 = $::avahi::deny_interfaces
  $disable_publishing              = $::avahi::disable_publishing
  $disable_user_service_publishing = $::avahi::disable_user_service_publishing
  $disallow_other_stacks           = $::avahi::disallow_other_stacks
  $domain_name                     = $::avahi::domain_name
  $enable_dbus                     = $::avahi::enable_dbus
  $enable_reflector                = $::avahi::enable_reflector
  $enable_wide_area                = $::avahi::enable_wide_area
  $entries_per_entry_group_max     = $::avahi::entries_per_entry_group_max
  $host_name                       = $::avahi::host_name
  $objects_per_client_max          = $::avahi::objects_per_client_max
  $publish_aaaa_on_ipv4            = $::avahi::publish_aaaa_on_ipv4
  $publish_a_on_ipv6               = $::avahi::publish_a_on_ipv6
  $publish_addresses               = $::avahi::publish_addresses
  $publish_dns_servers             = $::avahi::publish_dns_servers
  $publish_domain                  = $::avahi::publish_domain
  $publish_hinfo                   = $::avahi::publish_hinfo
  $publish_resolv_conf_dns_servers = $::avahi::publish_resolv_conf_dns_servers
  $publish_workstation             = $::avahi::publish_workstation
  $ratelimit_burst                 = $::avahi::ratelimit_burst
  $ratelimit_interval_usec         = $::avahi::ratelimit_interval_usec
  $reflect_ipv                     = $::avahi::reflect_ipv
  $rlimit_as                       = $::avahi::rlimit_as
  $rlimit_core                     = $::avahi::rlimit_core
  $rlimit_data                     = $::avahi::rlimit_data
  $rlimit_fsize                    = $::avahi::rlimit_fsize
  $rlimit_nofile                   = $::avahi::rlimit_nofile
  $rlimit_nproc                    = $::avahi::rlimit_nproc
  $rlimit_stack                    = $::avahi::rlimit_stack
  $use_iff_running                 = $::avahi::use_iff_running
  $use_ipv4                        = $::avahi::use_ipv4
  $use_ipv6                        = $::avahi::use_ipv6

  file { $conf_dir:
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  # FIXME concat, augeas, etc.
  file { "${conf_dir}/hosts":
    ensure => file,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  file { "${conf_dir}/services":
    ensure       => directory,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    force        => true,
    purge        => true,
    recurse      => true,
    recurselimit => 1,
  }

  file { "${conf_dir}/avahi-daemon.conf":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('avahi/avahi-daemon.conf.erb'),
  }

  ::dbus::system { 'avahi-dbus':
    content => file('avahi/avahi-dbus.conf'),
  }
}
