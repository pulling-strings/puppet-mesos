require 'spec_helper'
describe 'mesos' do

  context 'with defaults for all parameters' do
    it { should contain_class('mesos') }
  end
end
