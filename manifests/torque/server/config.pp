# moab::torque::server::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#

class moab::torque::server::config {

  include ::systemd::systemctl::daemon_reload

  $compute_nodes = $moab::torque::server::compute_nodes

  file { "${moab::torque::server::torque_home}/server_priv/nodes":
    ensure  => $moab::torque::server::ensure,
    content => template("${module_name}/torque/server/nodes.erb"),
    owner   => $moab::torque::server::torque_user,
    group   => $moab::torque::server::torque_group,
    mode    => '0644',
    notify  => Service['pbs_server'],
  }

  file { "${moab::torque::server::torque_home}/server_name":
    ensure  => $moab::torque::server::ensure,
    content => template("${module_name}/torque/server/server_name.erb"),
    owner   => $moab::torque::server::torque_user,
    group   => $moab::torque::server::torque_group,
    mode    => '0644',
    notify  => Service[['pbs_server', 'trqauthd']],
  }

  file { '/etc/systemd/system/pbs_server.service.d':
    ensure => directory,
    owner  => $moab::torque::server::torque_user,
    group  => $moab::torque::server::torque_group,
    mode   => '0640',
  }

  $_ha_arg = $moab::torque::server::ha ? { true => '--ha', default => undef }
  $_pbs_args = concat($moab::torque::server::pbs_args, $_ha_arg)

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
