# moab::workloadmanager::server::package
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::workloadmanager::server::package {

  $merged_packages = concat( [$moab::workloadmanager::server::base_package], $moab::workloadmanager::server::dependancy_packages )

  if $moab::workloadmanager::server::ensure == 'present' {
    $package_ensure = $moab::workloadmanager::server::version
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
