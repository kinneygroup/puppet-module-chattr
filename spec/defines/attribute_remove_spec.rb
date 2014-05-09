require 'spec_helper'
describe 'chattr::attribute_remove' do

  context 'with default values for params' do
    let(:title) { '/tmp/foo' }
    let(:facts) { { :kernel => 'Linux' } }

    it {
      should contain_exec('chattr -i /tmp/foo').with({
        'path'   => '/bin:/usr/bin:/sbin:/usr/sbin',
        'onlyif' => 'lsattr /tmp/foo | awk \'{print $1}\' |grep i',
        'tag'    => 'chattr_attribute_remove',
      })
    }
  end

  context 'with attribute params specified' do
    context 'as a valid value' do
      let(:title) { '/tmp/foo' }
      let(:params) { { :attribute => 'd' } }
      let(:facts) { { :kernel => 'Linux' } }

      it {
        should contain_exec('chattr -i /tmp/foo').with({
          'path'   => '/bin:/usr/bin:/sbin:/usr/sbin',
          'onlyif' => 'lsattr /tmp/foo | awk \'{print $1}\' |grep d',
          'tag'    => 'chattr_attribute_remove',
        })
      }
    end

    context 'as an invalid value' do
      let(:title) { '/tmp/foo' }
      let(:params) { { :attribute => 'invalid' } }
      let(:facts) { { :kernel => 'Linux' } }

      it 'should fail' do
        expect {
          should contain_class('chattr')
        }.to raise_error(Puppet::Error)
      end
    end
  end
end
