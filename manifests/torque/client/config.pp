# moab::torque::client::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::torque::client::config (
  String $ensure                        = $moab::torque::client::ensure,
  String $torque_home                   = $moab::torque::client::torque_home,
  String $torque_user                   = $moab::torque::client::torque_user,
  String $torque_group                  = $moab::torque::client::torque_group,
  Array[String] $pbs_servers            = $moab::torque::client::pbs_servers,
  String $mom_host                      = $moab::torque::client::mom_host,
  String $mom_logevent                  = $moab::torque::client::mom_logevent,
  Array[String] $mom_priv_config_extras = $moab::torque::client::mom_priv_config_extras,
) {

  file { "${torque_home}/mom_priv/config":
    ensure  => $ensure,
    content => template("${module_name}/torque/client/mom_priv_config.erb"),
    owner   => $torque_user,
    group   => $torque_group,
    mode    => '0644',
    notify  => Service['pbs_mom'],
  }

  file { "${torque_home}/server_name":
    ensure  => $ensure,
    content => template("${module_name}/torque/client/server_name.erb"),
    owner   => $torque_user,
    group   => $torque_group,
    mode    => '0644',
    notify  => Service[['pbs_mom', 'trqauthd']],
  }
}
