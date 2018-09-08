# moab::workloadmanager::server::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::workloadmanager::server::config (
  String $version                                  = $moab::workloadmanager::server::version,
  String $ensure                                   = $moab::workloadmanager::server::ensure,
  String $moab_user                                = $moab::workloadmanager::server::moab_user,
  String $moab_group                               = $moab::workloadmanager::server::moab_group,
  String $shared_path                              = $moab::workloadmanager::server::shared_path,
  Optional[String] $moab_license_key               = $moab::workloadmanager::server::moab_license_key,
  Boolean $ha                                      = $moab::workloadmanager::server::ha,
  String $server_hostname                          = $moab::workloadmanager::server::server_hostname,
  String $server_port                              = $moab::workloadmanager::server::server_port,
  String $server_mode                              = $moab::workloadmanager::server::server_mode,
  Optional[String] $fbserver_hostname              = $moab::workloadmanager::server::fbserver_hostname,
  String $instance_name                            = $moab::workloadmanager::server::instance_name,
  Array[String] $moab_adminusers                   = $moab::workloadmanager::server::moab_adminusers,
  String $moab_loglevel                            = $moab::workloadmanager::server::moab_loglevel,
  Array $moab_hpc_cfg_extras                       = $moab::workloadmanager::server::moab_hpc_cfg_extras,
  String $moab_toolsdir                            = $moab::workloadmanager::server::moab_toolsdir,
  String $resourcemanager_name                     = $moab::workloadmanager::server::resourcemanager_name,
  String $resourcemanager_type                     = $moab::workloadmanager::server::resourcemanager_type,
  String $resourcemanager_submitcmd                = $moab::workloadmanager::server::resourcemanager_submitcmd,
  String $resourcemanager_pollinterval             = $moab::workloadmanager::server::resourcemanager_pollinterval,
  Array $moab_hpc_cfg_resourcemanager_extras       = $moab::workloadmanager::server::moab_hpc_cfg_resourcemanager_extras,
  Array $moab_hpc_cfg_allocationmanager_extras     = $moab::workloadmanager::server::moab_hpc_cfg_allocationmanager_extras,
  String $usedatabase                              = $moab::workloadmanager::server::usedatabase,
  Optional[Hash] $odbc_conf                        = $moab::workloadmanager::server::odbc_conf,
  Array $moab_hpc_cfg_databaseconfiguration_extras = $moab::workloadmanager::server::moab_hpc_cfg_databaseconfiguration_extras,
  Array $moab_hpc_cfg_statisticalprofiling_extras  = $moab::workloadmanager::server::moab_hpc_cfg_statisticalprofiling_extras,
  Array $moab_hpc_cfg_remoteviz_extras             = $moab::workloadmanager::server::moab_hpc_cfg_remoteviz_extras,
  Array $moab_hpc_cfg_nitroapplication_extras      = $moab::workloadmanager::server::moab_hpc_cfg_nitroapplication_extras,
  String $moab_maxjob                              = $moab::workloadmanager::server::moab_maxjob,
  Array $moab_hpc_cfg_maxjob_extras                = $moab::workloadmanager::server::moab_hpc_cfg_maxjob_extras,
  Array $moab_hpc_cfg_includes                     = $moab::workloadmanager::server::moab_hpc_cfg_includes,
) {

  $_config_dir = $version ? {
    /^9[.]/ => '/opt/moab/etc',
    default => '/etc/moab'
  }
  $_ensure = $ensure ? {
    'absent' => $ensure,
    default  => 'file',
  }

  File {
    owner  => $moab_user,
    group  => $moab_group,
  }

  if $ha {
    file { $shared_path:
      ensure => 'directory',
      mode   => '0770',
    }
  }

  file { "${_config_dir}/moab.hpc.cfg":
    ensure  => $_ensure,
    content => template("${module_name}/workloadmanager/moab.hpc.cfg.erb"),
    mode    => '0644',
  }

  $dsninfo_ensure = $usedatabase ? {
    'odbc'  => 'set',
    default => 'rm',
  }

  file { '/opt/moab/dsninfo.dsn':
    ensure => file,
    mode   => '0640',
    owner  => 'root',
    group  => 'root',
  }

  augeas { 'dsninfo.dsn':
    lens    => 'Odbc.lns',
    incl    => '/opt/moab/dsninfo.dsn',
    changes => $odbc_conf.join_keys_to_values(" '").suffix("'").prefix("${dsninfo_ensure} ODBC/"),
    notify  => Service['moab'],
    require => File['/opt/moab/dsninfo.dsn'],
  }

  if $moab::workloadmanager::server::moab_license_key {
    $moab_license_file_ensure = 'file'
  } else {
    $moab_license_file_ensure = 'absent'
  }
  file { "${_config_dir}/moab.lic":
    ensure  => $moab_license_file_ensure,
    content => $moab_license_key,
    mode    => '0640',
    notify  => Service['moab'],
  }

}
