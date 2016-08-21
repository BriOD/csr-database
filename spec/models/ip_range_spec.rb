require 'rails_helper'

RSpec.describe IpRange, type: :model do
  describe 'IpRange' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:ip_range, network: '10.10.0.1/24', gateway: '10.10.0.1')).to be_valid
    end

    it 'must have a valid ip address and cidr for the network' do
      expect(FactoryGirl.build(:ip_range, network: '192.168.0.1')).to_not be_valid
      expect(FactoryGirl.build(:ip_range, network: 'network')).to_not be_valid
      expect(FactoryGirl.build(:ip_range, gateway: '10.10.0.1', network: '192.168.0.1/24')).to be_valid
    end

    it 'must have a valid ip address for the gateway' do
      expect(FactoryGirl.build(:ip_range, gateway: 'gateway')).to_not be_valid
    end

    it 'must have a service_id' do
      expect(FactoryGirl.build(:ip_range, service_id: nil)).to_not be_valid
    end

    it 'cannot have the same network or gateway as a previous IP Range' do
      expect(FactoryGirl.create(:ip_range, network: '192.168.0.1/24')).to be_valid
      # Trying to use Same Network
      expect(FactoryGirl.build(:ip_range, network: '192.168.0.1/24')).to_not be_valid
      # Change to New Network
      expect(FactoryGirl.build(:ip_range, network: '192.168.1.1/24')).to_not be_valid
      # Change both Network & Gateway
      expect(FactoryGirl.build(:ip_range, network: '192.168.1.1/24', gateway: '192.168.1.1')).to be_valid
    end
  end
end
