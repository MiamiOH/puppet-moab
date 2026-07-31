require 'spec_helper'

describe 'moab::repriselicensemanager::server::config' do
  let(:pre_condition) do
    <<-PUPPET
    class { 'moab::repriselicensemanager::server':
      version                   => '9.0.0',
      ensure                    => 'present',
      web_interface             => true,
      service_ensure            => 'running',
      service_enable            => true,
      packages                  => ['rlm'],
      workloadmanager_license_key => 'TEST-LICENSE',
    }
    PUPPET
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it do
        is_expected.to contain_file('/opt/moab/etc/moab.lic')
          .with(
            ensure: 'file',
            mode: '0640',
            content: 'TEST-LICENSE',
          )
      end

      it { is_expected.to contain_exec('mschedctl') }

      it { is_expected.to contain_systemd__unit_file('rlm.service') }

      it { is_expected.to contain_systemd__dropin_file('rlmargs.conf') }
    end
  end

  context 'with RLM version 9.1.0 or newer' do
    let(:pre_condition) do
      <<-PUPPET
      class { 'moab::repriselicensemanager::server':
        version                     => '9.1.0',
        ensure                      => 'present',
        web_interface               => true,
        service_ensure              => 'running',
        service_enable              => true,
        packages                    => ['rlm'],
        workloadmanager_license_key => 'TEST-LICENSE',
      }
      PUPPET
    end

    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }

        it { is_expected.to compile }

        it do
          is_expected.to contain_file('/opt/moab/etc/moab-rlm.lic')
            .with(
              ensure: 'file',
              mode: '0640',
              content: 'TEST-LICENSE',
            )
        end
      end
    end
  end
end
