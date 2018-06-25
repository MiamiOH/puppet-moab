# moab::repriselicensemanager::server::package
#
# Package installer for Reprise License Manager
#
# @summary Package installer for Reprise License Manager
#
class moab::repriselicensemanager::server::package (
  String $ensure          = $moab::repriselicensemanager::server::ensure,
  String $version         = $moab::repriselicensemanager::server::version,
  Array[String] $packages = $moab::repriselicensemanager::server::packages,
){

  if $ensure == 'present' {
    $package_ensure = $version
    $package_provider = undef
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $packages, { ensure => $package_ensure } )

}
