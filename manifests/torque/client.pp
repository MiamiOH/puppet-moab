# moab::torque::client
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::torque::client
class moab::torque::client (
  String $version,
  String $ensure,
  Boolean $ha,
  String $torque_user,
  String $torque_group,
  String $torque_home,
  String $service_ensure,
  String $service_enable,
  String $mom_host,
  String $mom_logevent,
  Array[String] $packages,
  Array[String] $pbs_servers = [],
  Array[String] $mom_priv_config_extras = [],
) {

  contain '::moab::torque::client::package'
  contain '::moab::torque::client::config'
  contain '::moab::torque::client::service'

  Class['::moab::torque::client::package']
  -> Class['::moab::torque::client::config']
  -> Class['::moab::torque::client::service']

}
