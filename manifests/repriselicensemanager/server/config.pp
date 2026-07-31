# moab::repriselicensemanager::server::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
#
# @param ensure
#   Whether the Reprise License Manager configuration should exist.
#
# @param version
#   Version of the Reprise License Manager package being configured.
#
# @param web_interface
#   Whether to enable the RLM web interface.
#
# @param workloadmanager_license_key
#   Moab workload manager license contents.
#
class moab::repriselicensemanager::server::config (
  Enum['present','absent'] $ensure                                = $moab::repriselicensemanager::server::ensure,
  String $version                               = $moab::repriselicensemanager::server::version,
  Boolean $web_interface                        = $moab::repriselicensemanager::server::web_interface,
  Optional[String] $workloadmanager_license_key = $moab::repriselicensemanager::server::workloadmanager_license_key,
) {
  $_rlm_ensure = $ensure ? {
    'absent' => $ensure,
    default  => 'file',
  }

  $_mwm_config_dir = '/opt/moab/etc'
  if versioncmp($version, '9.1.0') < 0 {
    $_mwm_license_file = 'moab.lic'
  } else {
    $_mwm_license_file = 'moab-rlm.lic'
  }

  if $workloadmanager_license_key {
    $_workloadmanager_license_file_ensure = $_rlm_ensure
  } else {
    $_workloadmanager_license_file_ensure = 'absent'
  }

  file { "${_mwm_config_dir}/${_mwm_license_file}":
    ensure  => $_workloadmanager_license_file_ensure,
    content => $workloadmanager_license_key,
    mode    => '0640',
  }

  exec { 'mschedctl':
    command     => 'mschedctl -R',
    path        => '/opt/moab/bin',
    subscribe   => File["${_mwm_config_dir}/${_mwm_license_file}"],
    refreshonly => true,
  }

  systemd::unit_file { 'rlm.service':
    source => "puppet:///modules/${module_name}/repriselicensemanager/rlm.service",
    notify => Service['rlm'],
  }

  $rlm_arg = $web_interface ? { false => '-nows', default => undef }

  # lint:ignore:strict_indent
  $rlm_args_conf = @("END"/L)
    [Service]
    Environment="RLM_ARGS=${rlm_arg}"
    | END
  # lint:endignore

  $rlm_args_conf_ensure = $web_interface ? { true => 'absent', default => $_rlm_ensure }

  systemd::dropin_file { 'rlmargs.conf':
    ensure  => $rlm_args_conf_ensure,
    unit    => 'rlm.service',
    content => $rlm_args_conf,
    notify  => Service['rlm'],
  }
}
