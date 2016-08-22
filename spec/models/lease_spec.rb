require 'rails_helper'

RSpec.describe Lease, type: :model do
  describe 'validations' do
    let(:service) { FactoryGirl.create(:service) }
    let(:ip_range) { FactoryGirl.create(:ip_range, service_id: service.id) }
    let(:ip_address) { FactoryGirl.create(:ip_address, ip_range_id: ip_range.id) }
    let(:address_book) { FactoryGirl.create(:address_book) }
    let(:customer) { FactoryGirl.create(:customer, address_book_id: address_book.id, ip_address_id: ip_address.id) }

    it 'has a valid factory' do
      expect(FactoryGirl.create(:lease, customer_id: customer.id)).to be_valid
    end
  end
end
