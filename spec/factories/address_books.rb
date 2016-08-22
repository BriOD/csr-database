require 'faker'

FactoryGirl.define do
  factory :address_book do |f|
    f.address_1 Faker::Address.street_address
    f.address_2 ''
    f.city Faker::Address.city
    f.state Faker::Address.state_abbr
    f.zipcode Faker::Address.zip
  end
end
