# moab::repriselicensemanager::server::package
#
# Package installer for Reprise License Manager
#
# @summary Package installer for Reprise License Manager
#
#
# @param ensure
#   Whether Reprise License Manager packages should be installed or removed.
#
# @param version
#   Version of the Reprise License Manager package to install.
#
# @param packages
#   List of packages required for the Reprise License Manager installation.
#
class moab::repriselicensemanager::server::package (
  Enum['present','absent'] $ensure          = $moab::repriselicensemanager::server::ensure,
  String $version         = $moab::repriselicensemanager::server::version,
  Array[String] $packages = $moab::repriselicensemanager::server::packages,
) {
  if $ensure == 'present' {
    $package_ensure = $version
  } else {
    if ($facts['os']['family'] == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $packages, { ensure => $package_ensure })
}
