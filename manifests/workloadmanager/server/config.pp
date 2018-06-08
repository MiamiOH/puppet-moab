# moab::workloadmanager::server::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class moab::workloadmanager::server::config {

  $_config_dir = $moab::workloadmanager::server::version ? {
    /^9[.]/ => '/opt/moab/etc',
    default => '/etc/moab'
  }
  $_ensure = $moab::workloadmanager::server::ensure ? {
    'absent' => $moab::workloadmanager::server::ensure,
    default  => 'file',
  }

  File {
    owner  => $moab::workloadmanager::server::moab_user,
    group  => $moab::workloadmanager::server::moab_group,
  }

  file { $moab::workloadmanager::server::shared_path:
    ensure => 'directory',
    mode   => '0770',
  }

  file { "${_config_dir}/moab.hpc.cfg":
    ensure  => $_ensure,
    content => template("${module_name}/workloadmanager/moab.hpc.cfg.erb"),
    mode    => '0644',
  }

  if $moab::workloadmanager::server::moab_license_key {
    $moab_license_file_ensure = 'present'
  } else {
    $moab_license_file_ensure = 'absent'
  }
  file { "${_config_dir}/moab.lic":
    ensure  => $moab_license_file_ensure,
    content => $moab::workloadmanager::server::moab_license_key,
    mode    => '0640',
    notify  => Service['moab'],
  }

}
