# moab::repriselicensemanager::server::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::repriselicensemanager::server::config {

  $_rlm_ensure = $moab::repriselicensemanager::server::ensure ? {
    'absent' => $moab::repriselicensemanager::server::ensure,
    default  => 'file',
  }

  $_mwm_config_dir = '/opt/moab/etc'
  if versioncmp($moab::repriselicensemanager::server::version, '9.1.0') < 0 {
    $_mwm_license_file = 'moab.lic'
  } else {
    $_mwm_license_file = 'moab-rlm.lic'
  }

  if $moab::repriselicensemanager::server::workloadmanager_license_key {
    $_workloadmanager_license_file_ensure = $_rlm_ensure
  } else {
    $_workloadmanager_license_file_ensure = 'absent'
  }

  file { "${_mwm_config_dir}/${_mwm_license_file}":
    ensure  => $_workloadmanager_license_file_ensure,
    content => $moab::repriselicensemanager::server::workloadmanager_license_key,
    mode    => '0640',
  }

  exec { 'mschedctl':
    command     => 'mschedctl –R',
    path        => '/opt/moab/bin',
    subscribe   => File["${_mwm_config_dir}/${_mwm_license_file}"],
    refreshonly => true,
  }

  systemd::unit_file { 'rlm.service':
    source => "puppet:///modules/${module_name}/repriselicensemanager/rlm.service",
  } ~> service { 'rlm.service':
    ensure => 'running',
  }

  $rlm_arg = $moab::repriselicensemanager::server::web_interface ? { false => '-nows', default => undef }

  # lint:ignore:strict_indent
  $rlm_args_conf = @("END"/L)
    [Service]
    Environment="RLM_ARGS=${rlm_arg}"
    | END
  # lint:endignore

  $rlm_args_conf_ensure = $moab::repriselicensemanager::server::web_interface ? { true => 'absent', default => $_rlm_ensure }

  systemd::dropin_file { 'rlmargs.conf':
    ensure  => $rlm_args_conf_ensure,
    unit    => 'rlm.service',
    content => $rlm_args_conf,
    notify  => Service['rlm'],
  }

}
