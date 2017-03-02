require 'spec_helper'

describe 'mail_aliases', :type => :class do
  after :each do
    Facter.clear
    Facter.clear_messages
  end

  context 'Unsupported OS' do
    let(:facts) {{
      :os => {
        :family => 'Solaris'
      }
    }}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError, /OS family 'Solaris' is not supported by this module/)
    end
  end

  ['RedHat', 'Debian', 'Suse'].each do |osfam|
    context "${osfam} OS and no hiera data" do
      let(:facts) {{
        :os => {
          :family => osfam
        },
        :testname => 'no_hiera_data'
      }}

      it { should compile }
      it { should contain_class('mail_aliases') }
      it { should have_mailalias_resource_count(0) }
    end

    context "${osfam} OS and hiera data" do
      let(:facts) {{
        :os => {
          :family => osfam
        },
        :testname => 'with_hiera_data'
      }}

      it { should compile }
      it { should contain_class('mail_aliases') }
      it { should have_mailalias_resource_count(3) }
      it { should contain_exec('newaliases').with(
        'command'     => '/usr/bin/newaliases',
        'refreshonly' => true,
      ) }
      it { should contain_mailalias('root').with(
        'recipient' => 'admin@mailbox.com',
        'notify'    => 'Exec[newaliases]',
        'ensure'    => 'present',
      ) }
      it { should contain_mailalias('puppet').with(
        'recipient' => 'puppetmaster@mailbox.com',
        'notify'    => 'Exec[newaliases]',
        'ensure'    => 'present',
      ) }
      it { should contain_mailalias('olduser').with(
        'recipient' => 'movedto@another.com',
        'notify'    => 'Exec[newaliases]',
        'ensure'    => 'absent',
      ) }
    end
  end
end
