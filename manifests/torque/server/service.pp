# moab::torque::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::torque::server::service
class moab::torque::server::service (
  String $pbs_server_service_ensure = $moab::torque::server::service_ensure,
  String $trqauthd_service_ensure   = $moab::torque::server::service_ensure,
  String $pbs_server_service_enable = $moab::torque::server::service_enable,
  String $trqauthd_service_enable   = $moab::torque::server::service_enable,
){

  service { 'pbs_server':
    ensure     => $pbs_server_service_ensure,
    enable     => $pbs_server_service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
  service { 'trqauthd':
    ensure     => $trqauthd_service_ensure,
    enable     => $trqauthd_service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
