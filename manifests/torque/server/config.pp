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

  # lint:ignore:strict_indent
  $ha_conf = @("END"/L)
    [Service]
    Environment=PBS_ARGS=--ha
    | END
  # lint:endignore

  $ha_conf_ensure = $moab::torque::server::ha ? { true => 'present', default => 'absent' }

  systemd::dropin_file { 'ha.conf':
    ensure  => $ha_conf_ensure,
    unit    => 'pbs_server.service',
    content => $ha_conf,
    notify  => Service['pbs_server'],
  }

}
