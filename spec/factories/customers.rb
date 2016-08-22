require 'faker'

FactoryGirl.define do
  factory :customer do |f|
    f.first_name Faker::Name.first_name
    f.last_name Faker::Name.last_name
    f.home_phone Faker::Number.number(10)
    f.ip_address_id '1'
    f.notes Faker::Lorem.paragraph
    f.email Faker::Internet.safe_email
    f.active true
  end
end
