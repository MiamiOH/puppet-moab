require 'spec_helper'

describe 'moab::workloadmanager::server::service' do
  let(:pre_condition) { 'include moab::workloadmanager::server' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it do
        is_expected.to contain_service('moab')
          .with(
            hasstatus: true,
            hasrestart: true,
          )
      end
    end
  end
end
