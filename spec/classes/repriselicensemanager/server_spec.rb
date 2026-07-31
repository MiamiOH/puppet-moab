require 'spec_helper'

describe 'moab::repriselicensemanager::server' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to contain_class('moab::repriselicensemanager::server::package') }
      it { is_expected.to contain_class('moab::repriselicensemanager::server::config') }
      it { is_expected.to contain_class('moab::repriselicensemanager::server::service') }
    end
  end
end
