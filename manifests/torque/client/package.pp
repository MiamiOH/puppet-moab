# moab::torque::client::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::torque::client::package
class moab::torque::client::package (
  Array[String] $packages,
  $version = $::moab::torque::client::version,
) inherits ::moab::torque::client {

  if $moab::torque::client::ensure == 'present' {
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
