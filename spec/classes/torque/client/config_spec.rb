require 'spec_helper'

describe 'moab::torque::client::config' do
  let(:pre_condition) { 'include moab::torque::client' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it do
        is_expected.to contain_file('/var/spool/torque/mom_priv/config')
          .with(
            owner: 'root',
            group: 'root',
            mode: '0644',
          )
      end

      it do
        is_expected.to contain_file('/var/spool/torque/server_name')
          .with(
            owner: 'root',
            group: 'root',
            mode: '0644',
          )
      end
    end
  end
end
