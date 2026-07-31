# moab::torque::server
#
# Installs and configures a Torque batch scheduler server.
#
# @summary Manage Torque server configuration and services.
#
# @param version
#   Torque package version.
#
# @param ensure
#   Whether Torque should be installed or removed.
#
# @param ha
#   Enable high availability mode.
#
# @param torque_user
#   User running Torque services.
#
# @param torque_group
#   Group owning Torque files.
#
# @param shared_path
#   Shared filesystem path for HA configuration.
#
# @param torque_home
#   Torque installation directory.
#
# @param service_ensure
#   Desired service state.
#
# @param service_enable
#   Whether Torque services start at boot.
#
# @param base_package
#   Main Torque package.
#
# @param dependency_packages
#   Additional Torque dependencies.
#
# @param pbs_servers
#   PBS server hostnames.
#
# @param pbs_args
#   Additional PBS server arguments.
#
# @param compute_nodes
#   Compute node definitions.
#
# @param torque_cfg_extras
#   Additional Torque configuration entries.
#
# @example
#   include moab::torque::server
class moab::torque::server (
  String $version,
  Enum['present','absent'] $ensure,
  Boolean $ha,
  String $torque_user,
  String $torque_group,
  String $shared_path,
  String $torque_home,
  Enum['running','stopped'] $service_ensure,
  Boolean $service_enable,
  String $base_package,
  Array[String] $dependency_packages,
  Array[String] $pbs_servers = [],
  Array[String] $pbs_args = [],
  Hash $compute_nodes = {},
  Array[String] $torque_cfg_extras = [],
) {
  contain 'moab::torque::server::package'
  contain 'moab::torque::server::config'
  contain 'moab::torque::server::service'

  Class['moab::torque::server::package']
  -> Class['moab::torque::server::config']
  -> Class['moab::torque::server::service']
}
