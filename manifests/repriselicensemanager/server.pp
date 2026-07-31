# moab::repriselicensemanager::server
#
# Installs and configures the Reprise License Manager service used by Moab.
#
# @summary Manage the Moab Reprise License Manager server.
#
# @param version
#   Version of the license manager package.
#
# @param ensure
#   Whether the license manager should be installed or removed.
#
# @param web_interface
#   Enable the RLM web interface.
#
# @param service_ensure
#   Desired service state.
#
# @param service_enable
#   Whether the service starts at boot.
#
# @param packages
#   Packages required for the license manager.
#
# @param workloadmanager_license_key
#   Moab workload manager license contents.
#
# @param elastic_license_key
#   Elastic license contents.
#
# @param viewpoint_license_key
#   Viewpoint license contents.
#
# @param nitro_license_key
#   Nitro license contents.
#
# @example
#   include moab::repriselicensemanager::server
class moab::repriselicensemanager::server (
  String $version,
  Enum['present','absent'] $ensure,
  Boolean $web_interface,
  Enum['running','stopped'] $service_ensure,
  Boolean $service_enable,
  Array[String] $packages,
  Optional[String] $workloadmanager_license_key = undef,
  Optional[String] $elastic_license_key = undef,
  Optional[String] $viewpoint_license_key = undef,
  Optional[String] $nitro_license_key = undef,
) {
  contain 'moab::repriselicensemanager::server::package'
  contain 'moab::repriselicensemanager::server::config'
  contain 'moab::repriselicensemanager::server::service'

  Class['moab::repriselicensemanager::server::package']
  -> Class['moab::repriselicensemanager::server::config']
  -> Class['moab::repriselicensemanager::server::service']
}
