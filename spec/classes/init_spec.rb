require 'spec_helper'
describe 'chattr' do

  it { should compile.with_all_deps }

  context 'with defaults for all parameters' do
    it { should contain_class('chattr') }
  end

  context 'with attribute_adds specified as a hash' do
    let(:facts) { { :kernel => 'Linux' } }
    let(:params) { {
      :attribute_adds_hiera_merge => false,
      :attribute_adds => {
        '/tmp/foo' => {
        },
        '/tmp/bar' => {
          'attribute' => 'd',
      }
    } } }

    it { should contain_class('chattr') }

    it {
      should contain_exec('chattr +i /tmp/foo').with({
        'path'   => '/bin:/usr/bin:/sbin:/usr/sbin',
        'unless' => 'lsattr /tmp/foo | awk \'{print $1}\' |grep i',
        'tag'    => 'chattr_attribute_add',
      })
    }

    it {
      should contain_exec('chattr +i /tmp/bar').with({
        'path'   => '/bin:/usr/bin:/sbin:/usr/sbin',
        'unless' => 'lsattr /tmp/bar | awk \'{print $1}\' |grep d',
        'tag'    => 'chattr_attribute_add',
      })
    }
  end

  context 'with attribute_adds specified as an invalid type' do
    let(:params) { { :crons => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('chattr')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with attribute_adds_hiera_merge specified as an invalid type' do
    let(:params) { { :attribute_adds_hiera_merge => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('chattr')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with attribute_removes specified as a hash' do
    let(:facts) { { :kernel => 'Linux' } }
    let(:params) { {
      :attribute_removes_hiera_merge => false,
      :attribute_removes => {
        '/tmp/foo' => {
        },
        '/tmp/bar' => {
          'attribute' => 'd',
      }
    } } }

    it { should contain_class('chattr') }

    it {
      should contain_exec('chattr -i /tmp/foo').with({
        'path'   => '/bin:/usr/bin:/sbin:/usr/sbin',
        'onlyif' => 'lsattr /tmp/foo | awk \'{print $1}\' |grep i',
        'tag'    => 'chattr_attribute_remove',
      })
    }

    it {
      should contain_exec('chattr -i /tmp/bar').with({
        'path'   => '/bin:/usr/bin:/sbin:/usr/sbin',
        'onlyif' => 'lsattr /tmp/bar | awk \'{print $1}\' |grep d',
        'tag'    => 'chattr_attribute_remove',
      })
    }
  end

  context 'with attribute_removes specified as an invalid type' do
    let(:params) { { :crons => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('chattr')
      }.to raise_error(Puppet::Error)
    end
  end

  context 'with attribute_removes_hiera_merge specified as an invalid type' do
    let(:params) { { :attribute_removes_hiera_merge => ['not','a','hash'] } }

    it 'should fail' do
      expect {
        should contain_class('chattr')
      }.to raise_error(Puppet::Error)
    end
  end
end
