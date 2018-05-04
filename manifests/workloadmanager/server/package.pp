# moab::workloadmanager::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::workloadmanager::server::package
class moab::workloadmanager::server::package (
  String $base_package,
  Array[String] $dependancy_packages,
  $version = $::moab::workloadmanager::version,
) inherits ::moab::workloadmanager::server {

  $merged_packages = concat( [$base_package], $dependancy_packages )

  if $moab::workloadmanager::server::ensure == 'present' {
    $package_ensure = $version
    $package_provider = undef
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $merged_packages, { ensure => $package_ensure } )

}
