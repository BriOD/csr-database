require 'rails_helper'

RSpec.describe IpRange, type: :model do
  let(:service) { FactoryGirl.create(:service) }
  let(:ip_range) { FactoryGirl.create(:ip_range, network: '192.168.99.1/24', gateway: '192.168.99.1', service_id: service.id) }
  let(:ip_ranges) do
    ip_range.create_ip_addresses
    ip_range
  end

  describe 'validation' do
    it 'has a valid factory' do
      expect(service).to be_valid
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

  describe 'methods' do
    it '.name shows the name of the ip range without the CIDR (/24, /28, etc)' do
      expect(ip_range.name).to eq('192.168.99.0')
    end

    it '.subnet_mask shows an ip ranges subnet mask' do
      expect(ip_range.subnet_mask).to eq('255.255.255.0')
    end

    it '.create_ip_addresses iterates through the ip range and creates an ip address object for each entry' do
      ip_range.create_ip_addresses
    end

    it '.unassigned returns a count of unassigned ip addresses in a range' do
      ip_range.create_ip_addresses
      expect(ip_range.unassigned).to eq(253)
    end

    it '.assigned returns a count of assigned ip addresses in a range' do
      ip_range.create_ip_addresses
      ip_range.ip_addresses.first.update(reserved: true)
      expect(ip_range.assigned).to eq(1)
    end

    it '.percentage_used returns the percentage of a range that has been assigned' do
      ip_range.create_ip_addresses
      counter = 0
      25.times do
        ip_range.ip_addresses[counter].update(reserved: true)
        counter += 1
      end
      expect(ip_range.percentage_used).to eq(9)
    end
  end
end
