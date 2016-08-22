require 'faker'

FactoryGirl.define do
  factory :webspace do |f|
    f.customer_id 1
    f.active true
    f.url 'http://username.example.com'
    f.username 'username'
    f.password 'password'
  end
end
