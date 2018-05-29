# moab::torque::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::torque::server::package {

  $merged_packages = concat( [$moab::torque::server::base_package], $moab::torque::server::dependancy_packages )

  if $moab::torque::server::ensure == 'present' {
    $package_ensure = $moab::torque::server::version
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $merged_packages, { ensure => $package_ensure } )

}
