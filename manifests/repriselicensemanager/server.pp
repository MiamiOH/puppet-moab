# moab::repriselicensemanager::server
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::repriselicensemanager::server
class moab::repriselicensemanager::server (
  String $version,
  String $ensure,
  Boolean $web_interface,
  String $service_ensure,
  String $service_enable,
  Array[String] $packages,
  Optional[String] $workloadmanager_license_key = undef,
  Optional[String] $elastic_license_key = undef,
  Optional[String] $viewpoint_license_key = undef,
  Optional[String] $nitro_license_key = undef,
) {

  contain '::moab::repriselicensemanager::server::package'
  contain '::moab::repriselicensemanager::server::config'
  contain '::moab::repriselicensemanager::server::service'

  Class['::moab::repriselicensemanager::server::package']
  -> Class['::moab::repriselicensemanager::server::config']
  -> Class['::moab::repriselicensemanager::server::service']

}
