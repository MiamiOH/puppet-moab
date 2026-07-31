# moab::workloadmanager::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
#
# @param service_ensure
#   Desired state of the Moab service.
#
# @param service_enable
#   Whether the Moab service starts at boot.
#
class moab::workloadmanager::server::service (
  Enum['running','stopped'] $service_ensure = $moab::workloadmanager::server::service_ensure,
  Boolean $service_enable = $moab::workloadmanager::server::service_enable,
) {
  service { 'moab':
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
