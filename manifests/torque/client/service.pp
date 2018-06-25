# moab::torque::client::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::torque::client::service (
  String $pbs_mom_service_ensure   = $moab::torque::client::service_ensure,
  String $pbs_mom_service_enabled  = $moab::torque::client::service_enable,
  String $trqauthd_service_ensure  = $moab::torque::client::service_ensure,
  String $trqauthd_service_enabled = $moab::torque::client::service_enable,
) {

  service { 'pbs_mom':
    ensure     => $pbs_mom_service_ensure,
    enable     => $pbs_mom_service_enabled,
    hasstatus  => true,
    hasrestart => true,
  }
  service { 'trqauthd':
    ensure     => $trqauthd_service_ensure,
    enable     => $trqauthd_service_enabled,
    hasstatus  => true,
    hasrestart => true,
  }

}
