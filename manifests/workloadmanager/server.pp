# moab::workloadmanager::server
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include moab::workloadmanager::server
class moab::workloadmanager::server (
  String $version,
  String $ensure,
  Boolean $ha,
  String $moab_user,
  String $moab_group,
  String $shared_path,
  String $instance_name,
  String $server_hostname,
  String $server_port,
  String $server_mode,
  String $service_ensure,
  String $service_enable,
  String $usedatabase,
  String $moab_toolsdir,
  String $moab_loglevel,
  String $moab_maxjob,
  String $resourcemanager_name,
  String $resourcemanager_type,
  String $resourcemanager_submitcmd,
  String $resourcemanager_pollinterval,
  String $allocationmanager_name,
  String $allocationmanager_type,
  String $allocationmanager_submitcmd,
  Array[String] $moab_adminusers,
  String $base_package,
  Array[String] $dependancy_packages,
  Optional[Hash] $odbc_conf = {},
  Optional[String] $moab_license_key = undef,
  Optional[String] $fbserver_hostname = undef,
  Array $moab_hpc_cfg_extras = [],
  Array $moab_hpc_cfg_resourcemanager_extras = [],
  Array $moab_hpc_cfg_allocationmanager_extras = [],
  Array $moab_hpc_cfg_databaseconfiguration_extras = [],
  Array $moab_hpc_cfg_statisticalprofiling_extras = [],
  Array $moab_hpc_cfg_remoteviz_extras = [],
  Array $moab_hpc_cfg_nitroapplication_extras = [],
  Array $moab_hpc_cfg_maxjob_extras = [],
  Array $moab_hpc_cfg_includes = [],
) {

  contain 'moab::workloadmanager::server::package'
  contain 'moab::workloadmanager::server::config'
  contain 'moab::workloadmanager::server::service'

  Class['moab::workloadmanager::server::package']
  -> Class['moab::workloadmanager::server::config']
  -> Class['moab::workloadmanager::server::service']

}
