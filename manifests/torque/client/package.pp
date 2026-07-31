# moab::torque::client::package
#
# Installs or removes Torque client packages.
#
# @summary Manage Torque client package installation.
#
# @param ensure
#   Whether Torque client packages should be installed or removed.
#
# @param version
#   Version of the Torque client packages to install.
#
# @param packages
#   List of packages required for the Torque client installation.
#
class moab::torque::client::package (
  Enum['present','absent'] $ensure = $moab::torque::client::ensure,
  String $version         = $moab::torque::client::version,
  Array[String] $packages = $moab::torque::client::packages,
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
