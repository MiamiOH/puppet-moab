# moab::torque::server::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @param ensure
#   Whether Torque server configuration files should exist.
#
# @param compute_nodes
#   Compute node definitions.
#
# @param torque_user
#   User account that owns Torque server configuration files.
#
# @param torque_group
#   Group that owns Torque server configuration files.
#
# @param torque_cfg_extras
#   Additional Torque configuration entries.
#
# @param shared_path
#   Shared filesystem path used for high availability configurations.
#
# @param torque_home
#   Torque installation directory.
#
# @param ha
#   Enable high availability configuration mode.
#
# @param pbs_servers
#   PBS server hostnames.
#
# @param pbs_args
#   Additional PBS server command line arguments.
#
class moab::torque::server::config (
  Enum['present','absent'] $ensure                   = $moab::torque::server::ensure,
  Hash $compute_nodes              = $moab::torque::server::compute_nodes,
  String $torque_user              = $moab::torque::server::torque_user,
  String $torque_group             = $moab::torque::server::torque_group,
  Array[String] $torque_cfg_extras = $moab::torque::server::torque_cfg_extras,
  String $shared_path              = $moab::torque::server::shared_path,
  String $torque_home              = $moab::torque::server::torque_home,
  Boolean $ha                      = $moab::torque::server::ha,
  Array[String] $pbs_servers       = $moab::torque::server::pbs_servers,
  Array[String] $pbs_args          = $moab::torque::server::pbs_args,
) {
  File {
    owner  => $torque_user,
    group  => $torque_group,
  }

  if $ha {
    file { $shared_path:
      ensure => 'directory',
      mode   => '0770',
    }
  }

  file { "${torque_home}/server_priv/nodes":
    ensure  => $ensure,
    content => template('moab/torque/server/nodes.erb'),
    mode    => '0644',
    notify  => Service['pbs_server'],
  }

  file { "${torque_home}/server_name":
    ensure  => $ensure,
    content => template('moab/torque/server/server_name.erb'),
    mode    => '0644',
    notify  => Service[['pbs_server', 'trqauthd']],
  }

  file { "${torque_home}/torque.cfg":
    ensure  => $ensure,
    content => template('moab/torque/server/torque.cfg.erb'),
    mode    => '0644',
    notify  => Service[['pbs_server', 'trqauthd']],
  }

  $_ha_arg = $ha ? { true => '--ha', default => undef }
  $_pbs_args = concat($pbs_args, $_ha_arg)

  # lint:ignore:strict_indent
  $pbsargs_conf = @("END"/L)
    [Service]
    Environment="PBS_ARGS=${_pbs_args.join(' ')}"
    | END
  # lint:endignore

  $pbsargs_conf_ensure = $_pbs_args.count ? { 0 => 'absent', default => 'present' }

  systemd::dropin_file { 'pbsargs.conf':
    ensure  => $pbsargs_conf_ensure,
    unit    => 'pbs_server.service',
    content => $pbsargs_conf,
    notify  => Service['pbs_server'],
  }
}
