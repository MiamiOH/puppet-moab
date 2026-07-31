# moab::repriselicensemanager::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
#
# @param service_ensure
#   Desired state of the Reprise License Manager service.
#
# @param service_enable
#   Whether the Reprise License Manager service starts at boot.
#
class moab::repriselicensemanager::server::service (
  Enum['running','stopped'] $service_ensure = $moab::repriselicensemanager::server::service_ensure,
  Boolean $service_enable = $moab::repriselicensemanager::server::service_enable,
) {
  service { 'rlm':
    ensure => $service_ensure,
    enable => $service_enable,
  }
}
