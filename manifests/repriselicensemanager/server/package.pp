# moab::repriselicensemanager::server::package
#
# Package installer for Reprise License Manager
#
# @summary Package installer for Reprise License Manager
#
class moab::repriselicensemanager::server::package {

  if $moab::repriselicensemanager::server::ensure == 'present' {
    $package_ensure = $moab::repriselicensemanager::server::version
    $package_provider = undef
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $moab::repriselicensemanager::server::packages, { ensure => $package_ensure } )

}
