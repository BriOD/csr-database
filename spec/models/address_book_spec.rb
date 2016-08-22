require 'rails_helper'

RSpec.describe AddressBook, type: :model do
  let(:service) { FactoryGirl.create(:service) }
  let(:ip_range) { FactoryGirl.create(:ip_range, service_id: service.id) }
  let(:ip_address) { FactoryGirl.create(:ip_address, ip_range_id: ip_range.id) }
  let(:address_book) { FactoryGirl.create(:address_book) }
  let(:customer) { FactoryGirl.create(:customer, address_book_id: address_book.id, ip_address_id: ip_address.id) }
  let(:company) { FactoryGirl.create(:company, address_book_id: address_book.id, customer_id: customer.id) }

  describe 'validations' do
    it 'has a valid factory' do
      expect(address_book).to be_valid
    end
  end

  context 'is attached' do
    it 'to a customer' do
      customer.address_book_id = address_book.id
      expect(address_book.customer).to_not be_nil
    end

    it 'to a company' do
      company.address_book_id = address_book.id
      expect(address_book.company).to_not be_nil
    end
  end
end
