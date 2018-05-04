# moab::repriselicensemanager::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::repriselicensemanager::server::package
class moab::repriselicensemanager::server::package () inherits ::moab::repriselicensemanager::server {

  if $::moab::repriselicensemanager::server::ensure == 'present' {
    $package_ensure = $::moab::repriselicensemanager::server::version
    $package_provider = undef
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages(  $::moab::repriselicensemanager::server::packages, { ensure => $package_ensure } )

}
