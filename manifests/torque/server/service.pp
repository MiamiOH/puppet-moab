# moab::torque::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::torque::server::service
class moab::torque::server::service {

  service { 'pbs_server':
    ensure     => $moab::torque::server::service_ensure,
    enable     => $moab::torque::server::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
  service { 'trqauthd':
    ensure     => $moab::torque::server::service_ensure,
    enable     => $moab::torque::server::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }

}
