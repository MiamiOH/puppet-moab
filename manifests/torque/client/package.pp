# moab::torque::client::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::torque::client::package {

  if $moab::torque::client::ensure == 'present' {
    $package_ensure = $moab::torque::client::version
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $moab::torque::client::packages, { ensure => $package_ensure } )

}
