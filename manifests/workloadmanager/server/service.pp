# moab::workloadmanager::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::workloadmanager::server::service (
  String $service_ensure = $moab::workloadmanager::server::service_ensure,
  String $service_enable = $moab::workloadmanager::server::service_enable,
) {

  service { 'moab':
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
