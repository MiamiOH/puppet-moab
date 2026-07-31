require 'spec_helper'

describe 'moab::workloadmanager::server::config' do
  let(:pre_condition) { 'include moab::workloadmanager::server' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it do
        is_expected.to contain_file('/opt/moab/etc/moab.hpc.cfg')
      end

      it do
        is_expected.to contain_file('/opt/moab/etc/moab.lic')
      end

      it do
        is_expected.to contain_file('/opt/moab/dsninfo.dsn')
          .with(
            owner: 'root',
            group: 'root',
            mode: '0640',
          )
      end

      it do
        is_expected.to contain_augeas('dsninfo.dsn')
      end
    end
  end
end
