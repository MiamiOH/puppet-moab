require 'spec_helper'

describe 'moab::torque::server::service' do
  let(:pre_condition) { 'include moab::torque::server' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to contain_service('pbs_server') }
      it { is_expected.to contain_service('trqauthd') }
    end
  end
end
