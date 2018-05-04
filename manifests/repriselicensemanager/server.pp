# moab::repriselicensemanager::server
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::repriselicensemanager::server
class moab::repriselicensemanager::server (
  $version = $::moab::repriselicensemanager::version,
  $ensure = $::moab::repriselicensemanager::ensure,
  $packages = [],
) inherits ::moab::repriselicensemanager {

  contain ::moab::repriselicensemanager::server::package

}
