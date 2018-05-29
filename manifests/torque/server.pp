# moab::torque::server
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::torque::server
class moab::torque::server (
  String $version,
  String $ensure,
  Boolean $ha,
  String $torque_user,
  String $torque_group,
  String $torque_home,
  String $service_ensure,
  String $service_enable,
  String $base_package,
  Array[String] $dependancy_packages,
  Array[String] $pbs_servers = [],
  Hash $compute_nodes = {},
  Hash $torque_hpc_cfg = {},
) {

  contain '::moab::torque::server::package'
  contain '::moab::torque::server::config'
  contain '::moab::torque::server::service'

  Class['::moab::torque::server::package']
  -> Class['::moab::torque::server::config']
  -> Class['::moab::torque::server::service']

}
