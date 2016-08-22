FactoryGirl.define do
  factory :lease do |f|
    f.customer_id c.id
    f.modem_manufacturer 'Westell'
    f.modem_model '327W'
    f.modem_serial Faker::Crypto.md5
    f.modem_mac Faker::Internet.mac_address
    f.tr069 true
  end
end
