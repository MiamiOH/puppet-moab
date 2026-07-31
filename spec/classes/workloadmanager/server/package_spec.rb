require 'spec_helper'

describe 'moab::workloadmanager::server::package' do
  let(:pre_condition) { 'include moab::workloadmanager::server' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to contain_package('moab-workload-manager') }
      it { is_expected.to contain_package('moab-workload-manager-common') }
      it { is_expected.to contain_package('moab-workload-manager-hpc-configuration') }
      it { is_expected.to contain_package('moab-perl-RRDs') }
    end
  end
end
