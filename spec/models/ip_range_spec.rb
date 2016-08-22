require 'rails_helper'

RSpec.describe IpRange, type: :model do
  describe 'validation' do
    let(:service) { FactoryGirl.create(:service) }

    it 'has a valid factory' do
      expect(FactoryGirl.create(:ip_range, service_id: service.id)).to be_valid
    end

    context 'checks validtaion of network' do
      it 'and must contain a CIDR (/24, /16, etc)' do
        expect(FactoryGirl.build(:ip_range, network: '192.168.0.1', service_id: service.id)).to_not be_valid
      end

      it 'and cannot accept a non-ip address string' do
        expect(FactoryGirl.build(:ip_range, network: 'network', service_id: service.id)).to_not be_valid
      end
    end

    it 'must have a valid ip address for the gateway' do
      expect(FactoryGirl.build(:ip_range, gateway: 'gateway', service_id: service.id)).to_not be_valid
    end

    it 'must have a service_id' do
      expect(FactoryGirl.build(:ip_range, service_id: nil)).to_not be_valid
    end

    context 'checks against previous ranges' do
      it 'and cannot have the same network' do
        FactoryGirl.create(:ip_range, service_id: service.id)
        expect(FactoryGirl.build(:ip_range, network: '192.168.0.2/24', service_id: service.id)).to_not be_valid
      end

      it 'and cannot have the same gateway' do
        FactoryGirl.create(:ip_range, service_id: service.id)
        expect(FactoryGirl.build(:ip_range, gateway: '192.168.0.1', service_id: service.id)).to_not be_valid
      end

      it 'and has a unique network and gateway' do
        FactoryGirl.create(:ip_range, service_id: service.id)
        expect(FactoryGirl.build(:ip_range, network: '192.168.5.1/24', gateway: '192.168.5.1', service_id: service.id)).to be_valid
      end
    end
  end
end
