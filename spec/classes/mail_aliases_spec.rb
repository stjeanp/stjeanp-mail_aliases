# frozen_string_literal: true

require 'spec_helper'

describe 'mail_aliases', type: 'class' do
  after :each do
    Facter.clear
    Facter.clear_messages
  end

  context 'Unsupported OS' do
    let(:facts) do
      {
        os: {
          family: 'Solaris'
        }
      }
    end

    it do
      is_expected.to raise_error(%r{OS family 'Solaris' is not supported by this module})
    end
  end

  ['RedHat', 'Debian', 'Suse'].each do |osfam|
    context "#{osfam} OS and no hiera data" do
      let(:facts) do
        {
          os: {
            family: osfam
          },
          testname: 'no_hiera_data'
        }
      end

      it { is_expected.to compile }
      it { is_expected.to contain_class('mail_aliases') }
      it { is_expected.to have_mailalias_resource_count(0) }
    end

    context "#{osfam} OS and hiera data" do
      let(:facts) do
        {
          os: {
            family: osfam
          },
          testname: 'with_hiera_data'
        }
      end

      it { is_expected.to compile }
      it { is_expected.to contain_class('mail_aliases') }
      it { is_expected.to have_mailalias_resource_count(3) }
      it {
        is_expected.to contain_exec('newaliases').with(
          'command'     => '/usr/bin/newaliases',
          'refreshonly' => true,
        )
      }
      it {
        is_expected.to contain_mailalias('root').with(
          'recipient' => 'admin@mailbox.com',
          'notify'    => 'Exec[newaliases]',
          'ensure'    => 'present',
        )
      }
      it {
        is_expected.to contain_mailalias('puppet').with(
          'recipient' => 'puppetmaster@mailbox.com',
          'notify'    => 'Exec[newaliases]',
          'ensure'    => 'present',
        )
      }
      it {
        is_expected.to contain_mailalias('olduser').with(
          'recipient' => 'movedto@another.com',
          'notify'    => 'Exec[newaliases]',
          'ensure'    => 'absent',
        )
      }
    end
  end
end
