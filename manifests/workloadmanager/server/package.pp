# moab::workloadmanager::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::workloadmanager::server::package (
  String $ensure                     = $moab::workloadmanager::server::ensure,
  String $version                    = $moab::workloadmanager::server::version,
  String $base_package               = $moab::workloadmanager::server::base_package,
  Array[String] $dependancy_packages = $moab::workloadmanager::server::dependancy_packages,
) {

  $merged_packages = concat( [$base_package], $dependancy_packages )

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

  ensure_packages( $merged_packages, { ensure => $package_ensure } )

}
