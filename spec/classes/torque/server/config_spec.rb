require 'spec_helper'

describe 'moab::torque::server::config' do
  let(:pre_condition) { 'include moab::torque::server' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it do
        is_expected.to contain_file('/var/spool/torque/server_priv/nodes')
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

      it do
        is_expected.to contain_file('/var/spool/torque/torque.cfg')
          .with(
            owner: 'root',
            group: 'root',
            mode: '0644',
          )
      end

      it do
        is_expected.to contain_systemd__dropin_file('pbsargs.conf')
          .with(
            unit: 'pbs_server.service',
          )
      end
    end
  end
end
