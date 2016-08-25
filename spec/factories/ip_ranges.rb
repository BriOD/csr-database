require 'faker'

FactoryGirl.define do
  factory :ip_range do |f|
    f.network '192.168.254.2/24'
    f.gateway '192.168.254.1'
    f.service_id 2
  end
end
