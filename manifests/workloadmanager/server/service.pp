# moab::workloadmanager::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::workloadmanager::server::service {

  service { 'moab':
    ensure     => $moab::workloadmanager::server::service_ensure,
    enable     => $moab::workloadmanager::server::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
