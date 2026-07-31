# moab::torque::client
#
# Installs and configures a Torque compute node client.
#
# @summary Manage Torque client configuration.
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
#   Torque service user.
#
# @param torque_group
#   Torque service group.
#
# @param torque_home
#   Torque installation directory.
#
# @param service_ensure
#   Desired service state.
#
# @param service_enable
#   Whether services start at boot.
#
# @param mom_host
#   Hostname of the Torque MOM service.
#
# @param mom_logevent
#   MOM logging event configuration.
#
# @param packages
#   Packages required for the Torque client.
#
# @param pbs_servers
#   PBS server hostnames.
#
# @param mom_priv_config_extras
#   Additional MOM configuration entries.
#
# @example
#   include moab::torque::client
class moab::torque::client (
  String $version,
  Enum['present','absent'] $ensure,
  Boolean $ha,
  String $torque_user,
  String $torque_group,
  String $torque_home,
  Enum['running','stopped'] $service_ensure,
  Boolean $service_enable,
  String $mom_host,
  String $mom_logevent,
  Array[String] $packages,
  Array[String] $pbs_servers = [],
  Array[String] $mom_priv_config_extras = [],
) {
  contain 'moab::torque::client::package'
  contain 'moab::torque::client::config'
  contain 'moab::torque::client::service'

  Class['moab::torque::client::package']
  -> Class['moab::torque::client::config']
  -> Class['moab::torque::client::service']
}
