FactoryGirl.define do
  factory :ip_range do |f|
    f.id IpRange.ip2long('192.168.1.1')
    f.network '192.168.0.2/24'
    f.gateway '192.168.0.1'
    f.service_id 3
  end
end
