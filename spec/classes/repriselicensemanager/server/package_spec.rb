require 'spec_helper'

describe 'moab::repriselicensemanager::server::package' do
  let(:pre_condition) do
    <<-PUPPET
    class { 'moab::repriselicensemanager::server':
      version        => '1.0.0',
      ensure         => 'present',
      web_interface  => true,
      service_ensure => 'running',
      service_enable => true,
      packages       => ['rlm'],
    }
    PUPPET
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it do
        is_expected.to contain_package('rlm')
          .with(
            ensure: '1.0.0',
          )
      end
    end
  end

  context 'with default package list' do
    let(:pre_condition) do
      <<-PUPPET
      class { 'moab::repriselicensemanager::server':
        version        => '1.0.0',
        ensure         => 'present',
        web_interface  => true,
        service_ensure => 'running',
        service_enable => true,
        packages       => ['ac-rlm'],
      }
      PUPPET
    end

    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        it { is_expected.to compile }

        it do
          is_expected.to contain_package('ac-rlm')
            .with(
              ensure: '1.0.0',
            )
        end
      end
    end
  end

  context 'when ensure is absent' do
    let(:pre_condition) do
      <<-PUPPET
      class { 'moab::repriselicensemanager::server':
        version        => '1.0.0',
        ensure         => 'absent',
        web_interface  => true,
        service_ensure => 'stopped',
        service_enable => false,
        packages       => ['rlm'],
      }
      PUPPET
    end

    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        it { is_expected.to compile }

        it do
          is_expected.to contain_package('rlm')
            .with(
              ensure: %r{absent|purged},
            )
        end
      end
    end
  end
end
