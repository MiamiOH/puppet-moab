# moab::torque::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @param ensure
#   Whether Torque server packages should be installed or removed.
#
# @param version
#   Version of the Torque packages to install.
#
# @param base_package
#   Primary Torque server package.
#
# @param dependency_packages
#   Additional packages required by Torque.
#
class moab::torque::server::package (
  Enum['present','absent'] $ensure                     = $moab::torque::server::ensure,
  String $version                    = $moab::torque::server::version,
  String $base_package               = $moab::torque::server::base_package,
  Array[String] $dependency_packages = $moab::torque::server::dependency_packages,
) {
  $merged_packages = concat([$base_package], $dependency_packages )

  if $ensure == 'present' {
    $package_ensure = $version
  } else {
    if ($facts['os']['family'] == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $merged_packages, { ensure => $package_ensure })
}
