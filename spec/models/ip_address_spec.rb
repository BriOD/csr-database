require 'rails_helper'

RSpec.describe IpAddress, type: :model do
  describe 'validation' do
    let(:service) { FactoryGirl.create(:service) }
    let(:ip_range) { FactoryGirl.create(:ip_range, service_id: service.id) }

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

    it 'can contain a customer_id'
    it 'can be reserved'
  end
end
