# moab::repriselicensemanager::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::repriselicensemanager::server::service {

  service { 'rlm':
    ensure => $moab::repriselicensemanager::server::service_ensure,
    enable => $moab::repriselicensemanager::server::service_enable,
  }

}
