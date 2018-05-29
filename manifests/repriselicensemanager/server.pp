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
  Array[String] $packages,
) {

  contain '::moab::repriselicensemanager::server::package'

}
