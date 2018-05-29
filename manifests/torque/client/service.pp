# moab::torque::client::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::torque::client::service {

  service { 'pbs_mom':
    ensure     => $moab::torque::client::service_ensure,
    enable     => $moab::torque::client::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
  service { 'trqauthd':
    ensure     => $moab::torque::client::service_ensure,
    enable     => $moab::torque::client::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
