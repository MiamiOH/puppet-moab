# moab::repriselicensemanager::server::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::repriselicensemanager::server::service (
  String $service_ensure = $moab::repriselicensemanager::server::service_ensure,
  String $service_enable = $moab::repriselicensemanager::server::service_enable,
){

  service { 'rlm':
    ensure => $service_ensure,
    enable => $service_enable,
  }

}
