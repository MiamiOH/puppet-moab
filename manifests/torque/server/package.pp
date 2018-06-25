# moab::torque::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::torque::server::package (
  String $ensure                     = $moab::torque::server::ensure,
  String $version                    = $moab::torque::server::version,
  String $base_package               = $moab::torque::server::base_package,
  Array[String] $dependancy_packages = $moab::torque::server::dependancy_packages,
) {

  $merged_packages = concat( [$base_package], $dependancy_packages )

  if $ensure == 'present' {
    $package_ensure = $version
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $merged_packages, { ensure => $package_ensure } )

}
