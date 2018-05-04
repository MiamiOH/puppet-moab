# moab::workloadmanager::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::workloadmanager::server::service
class moab::workloadmanager::server::service () inherits ::moab::workloadmanager::server {

  service { 'moab':
    ensure     => $moab::workloadmanager::server::service_ensure,
    enable     => $moab::workloadmanager::server::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
