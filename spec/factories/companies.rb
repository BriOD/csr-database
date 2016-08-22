require 'faker'

FactoryGirl.define do
  factory :company do |f|
    f.customer_id '1'
    f.name Faker::Company.name
    f.contact_first_name Faker::Name.first_name
    f.contact_last_name Faker::Name.last_name
    f.contact_email Faker::Internet.safe_email
    f.billing_email Faker::Internet.safe_email
    f.address_book_id '1'
    f.main_number Faker::PhoneNumber.phone_number
    f.contact_number Faker::PhoneNumber.phone_number
    f.fax Faker::PhoneNumber.phone_number
  end
end
