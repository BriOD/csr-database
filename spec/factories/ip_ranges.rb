FactoryGirl.define do
  factory :ip_range do
    IpRange.create(
      id: IpRange.ip2long('192.168.0.1'),
      network: '192.168.0.2/24',
      gateway: '192.168.0.1',
      service_id: 3
    )
  end
end
