require 'rails_helper'

RSpec.describe IpAddress, type: :model do
  let(:service) { FactoryGirl.create(:service) }
  let(:ip_range) { FactoryGirl.create(:ip_range, service_id: service.id) }
  let(:ip) { FactoryGirl.build(:ip_address, ip_range_id: nil, customer_id: 1, reserved: true) }

  describe 'validation' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:ip_address, ip_range_id: ip_range.id)).to be_valid
    end

    it 'has a unique ip' do
      FactoryGirl.create(:ip_address, ip_range_id: ip_range.id)
      expect(FactoryGirl.build(:ip_address, ip_range_id: ip_range.id)).to_not be_valid
    end

    it 'must contain a ip_range_id' do
      expect(FactoryGirl.build(:ip_address, ip_range_id: nil)).to_not be_valid
    end
  end

  describe 'attributes' do
    it 'can contain a customer_id' do
      expect(ip.customer_id).to eq(1)
    end

    it 'can be reserved' do
      expect(ip.reserved).to eq(true)
    end
  end
end
