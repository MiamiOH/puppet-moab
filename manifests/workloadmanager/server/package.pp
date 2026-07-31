# moab::workloadmanager::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
#
# @param ensure
#   Whether Moab packages should be installed or removed.
#
# @param version
#   Version of the Moab package to install.
#
# @param base_package
#   Primary Moab package name.
#
# @param dependency_packages
#   Additional packages required by Moab.
#
class moab::workloadmanager::server::package (
  Enum['present','absent'] $ensure                     = $moab::workloadmanager::server::ensure,
  String $version                    = $moab::workloadmanager::server::version,
  String $base_package               = $moab::workloadmanager::server::base_package,
  Array[String] $dependency_packages = $moab::workloadmanager::server::dependency_packages,
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
