# moab::torque::client::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::torque::client::config {

  $mom_host = $moab::torque::client::mom_host

  file { "${moab::torque::client::torque_home}/mom_priv/config":
    ensure  => $moab::torque::client::ensure,
    content => template("${module_name}/torque/client/mom_priv_config.erb"),
    owner   => $moab::torque::client::torque_user,
    group   => $moab::torque::client::torque_group,
    mode    => '0644',
    notify  => Service['pbs_mom'],
  }

  file { "${moab::torque::client::torque_home}/server_name":
    ensure  => $moab::torque::client::ensure,
    content => template("${module_name}/torque/client/server_name.erb"),
    owner   => $moab::torque::client::torque_user,
    group   => $moab::torque::client::torque_group,
    mode    => '0644',
    notify  => Service[['pbs_mom', 'trqauthd']],
  }
}
