require 'faker'

FactoryGirl.define do
  factory :ip_address do |f|
    f.ip_range_id 1
    f.customer_id nil
    f.ip '192.168.0.2'
    f.reserved false
  end
end
