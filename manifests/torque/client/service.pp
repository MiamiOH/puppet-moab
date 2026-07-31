# moab::torque::client::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @param pbs_mom_service_ensure
#   Desired state of the PBS MOM service.
#
# @param pbs_mom_service_enabled
#   Whether the PBS MOM service starts at boot.
#
# @param trqauthd_service_ensure
#   Desired state of the Torque authentication daemon service.
#
# @param trqauthd_service_enabled
#   Whether the Torque authentication daemon service starts at boot.
#
class moab::torque::client::service (
  Enum['running','stopped'] $pbs_mom_service_ensure   = $moab::torque::client::service_ensure,
  Boolean $pbs_mom_service_enabled                   = $moab::torque::client::service_enable,
  Enum['running','stopped'] $trqauthd_service_ensure  = $moab::torque::client::service_ensure,
  Boolean $trqauthd_service_enabled                  = $moab::torque::client::service_enable,
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
