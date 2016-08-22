require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:service) { FactoryGirl.create(:service) }
  let(:ip_range) { FactoryGirl.create(:ip_range, service_id: service.id) }
  let(:ip_address) { FactoryGirl.create(:ip_address, ip_range_id: ip_range.id) }
  let(:address_book) { FactoryGirl.create(:address_book) }
  let(:customer) { FactoryGirl.create(:customer, address_book_id: address_book.id, ip_address_id: ip_address.id) }
  let(:company) { FactoryGirl.create(:company, address_book_id: address_book.id, customer_id: customer.id) }

  describe 'validations' do
    it 'has a valid factory' do
      expect(customer).to be_valid
    end

    context 'must contain' do
      it 'a first & last name and no company' do
        cust = FactoryGirl.build(:customer, first_name: 'John', last_name: 'Smith', address_book_id: address_book.id, ip_address_id: ip_address.id)
        expect(cust.first_name).to_not be_nil
        expect(cust.last_name).to_not be_nil
        expect(cust.company).to be_nil
      end

      it 'a company without a first & last name' do
        comp_cust = FactoryGirl.build(:customer, first_name: nil, last_name: nil, address_book_id: address_book.id, ip_address_id: ip_address.id)
        comp_cust.build_company(
          name: Faker::Company.name,
          contact_first_name: Faker::Name.first_name,
          contact_last_name: Faker::Name.last_name,
          contact_email: Faker::Internet.safe_email,
          address_book_id: address_book.id
        )
        expect(comp_cust.first_name).to be_nil
        expect(comp_cust.last_name).to be_nil
        expect(comp_cust.company).to_not be_nil
      end

      it 'a first & last name and company' do
        customer.build_company(
          name: Faker::Company.name,
          contact_first_name: Faker::Name.first_name,
          contact_last_name: Faker::Name.last_name,
          contact_email: Faker::Internet.safe_email,
          address_book_id: address_book.id
        )
        expect(customer.first_name).to_not be_nil
        expect(customer.last_name).to_not be_nil
        expect(customer.company).to_not be_nil
      end
    end
  end
end
