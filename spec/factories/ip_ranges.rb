FactoryGirl.define do
  factory :ip_range do |f|
    f.network '192.168.0.2/24'
    f.gateway '192.168.0.1'
    f.service_id 2
  end
end
