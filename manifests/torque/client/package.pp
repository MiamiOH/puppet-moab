# moab::torque::client::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::torque::client::package (
  String $ensure          = $moab::torque::client::ensure,
  String $version         = $moab::torque::client::version,
  Array[String] $packages = $moab::torque::client::packages,
){

  if $ensure == 'present' {
    $package_ensure = $version
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $packages, { ensure => $package_ensure } )

}
