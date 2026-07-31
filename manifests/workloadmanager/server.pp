# moab::workloadmanager::server
#
# Installs and configures the Adaptive Computing Moab workload manager server.
#
# @summary Manage the Moab workload manager server installation and configuration.
#
# @param version
#   Version of the Moab package to install.
#
# @param ensure
#   Whether Moab should be installed or removed.
#
# @param ha
#   Enable high availability shared configuration mode.
#
# @param moab_user
#   User account used to run Moab services.
#
# @param moab_group
#   Group used for Moab files.
#
# @param shared_path
#   Shared filesystem path used for HA configurations.
#
# @param instance_name
#   Name of the Moab instance.
#
# @param server_hostname
#   Hostname of the Moab server.
#
# @param server_port
#   Port used by the Moab server.
#
# @param server_mode
#   Moab server operating mode.
#
# @param service_ensure
#   Desired state of the Moab service.
#
# @param service_enable
#   Whether the Moab service should start at boot.
#
# @param usedatabase
#   Database backend type used by Moab.
#
# @param moab_toolsdir
#   Location of Moab tools.
#
# @param moab_loglevel
#   Moab logging level.
#
# @param moab_maxjob
#   Maximum number of jobs supported by Moab.
#
# @param resourcemanager_name
#   Name of the resource manager integration.
#
# @param resourcemanager_type
#   Resource manager type.
#
# @param resourcemanager_submitcmd
#   Command used to submit jobs.
#
# @param resourcemanager_pollinterval
#   Resource manager polling interval.
#
# @param allocationmanager_name
#   Allocation manager name.
#
# @param allocationmanager_type
#   Allocation manager type.
#
# @param allocationmanager_submitcmd
#   Allocation manager submission command.
#
# @param moab_adminusers
#   List of Moab administrator users.
#
# @param base_package
#   Primary Moab package name.
#
# @param dependency_packages
#   Additional package dependencies required by Moab.
#
# @param odbc_conf
#   ODBC configuration values.
#
# @param moab_license_key
#   Moab license content.
#
# @param fbserver_hostname
#   Database server hostname.
#
# @param moab_hpc_cfg_extras
#   Additional moab.hpc.cfg entries.
#
# @param moab_hpc_cfg_resourcemanager_extras
#   Additional resource manager configuration entries.
#
# @param moab_hpc_cfg_allocationmanager_extras
#   Additional allocation manager configuration entries.
#
# @param moab_hpc_cfg_databaseconfiguration_extras
#   Additional database configuration entries.
#
# @param moab_hpc_cfg_statisticalprofiling_extras
#   Additional statistical profiling entries.
#
# @param moab_hpc_cfg_remoteviz_extras
#   Additional remote visualization entries.
#
# @param moab_hpc_cfg_nitroapplication_extras
#   Additional Nitro application entries.
#
# @param moab_hpc_cfg_maxjob_extras
#   Additional max job configuration entries.
#
# @param moab_hpc_cfg_includes
#   Additional configuration include statements.
#
# @example
#   include moab::workloadmanager::server
class moab::workloadmanager::server (
  String $version,
  Enum['present','absent'] $ensure,
  Boolean $ha,
  String $moab_user,
  String $moab_group,
  String $shared_path,
  String $instance_name,
  String $server_hostname,
  String $server_port,
  String $server_mode,
  Enum['running','stopped'] $service_ensure,
  Boolean $service_enable,
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
  Array[String] $dependency_packages,
  Hash $odbc_conf = {},
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
