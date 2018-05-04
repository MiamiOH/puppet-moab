# moab::torque::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::torque::server::package
class moab::torque::server::package (
  String $base_package,
  Array[String] $dependancy_packages,
  $version = $::moab::torque::server::version,
) inherits ::moab::torque::server {

  $merged_packages = concat( [$base_package], $dependancy_packages )

  if $moab::torque::server::ensure == 'present' {
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
