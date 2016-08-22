Service.create(
  [
    {
      icon: 'ban',
      main_type: 'unassigned',
      main_name: 'Unassigned'
    },
    {
      icon: 'desktop',
      main_type: 'dsl',
      main_name: 'DSL'
    },
    {
      icon: 'hdd-o',
      main_type: 'other',
      main_name: 'Other'
    },
    {
      icon: 'home',
      main_type: 'other',
      main_name: 'Tanglewood',
      sub_type: 'tanglewood',
      sub_name: 'Tanglewood'
    },
    {
      icon: 'signal',
      main_type: 'wifi',
      main_name: 'WiFi',
      sub_type: 'hamsprairie',
      sub_name: 'Hams Prairie'
    },
    {
      icon: 'signal',
      main_type: 'wifi',
      main_name: 'WiFi',
      sub_type: 'bentoncity',
      sub_name: 'Benton City'
    },
    {
      icon: 'signal',
      main_type: 'wifi',
      main_name: 'WiFi',
      sub_type: 'lakebreeze',
      sub_name: 'Lake Breeze'
    },
    {
      icon: 'rss',
      main_type: 'wireless',
      main_name: 'Wireless',
      sub_type: 'centralia3650',
      sub_name: 'Centralia 3650'
    },
    {
      icon: 'rss',
      main_type: 'wireless',
      main_name: 'Wireless',
      sub_type: 'fulton3650',
      sub_name: 'Fulton 3650'
    },
    {
      icon: 'rss',
      main_type: 'wireless',
      main_name: 'Wireless',
      sub_type: 'fulton900',
      sub_name: 'Fulton 900'
    },
    {
      icon: 'rss',
      main_type: 'wireless',
      main_name: 'Wireless',
      sub_type: 'mexico3650',
      sub_name: 'Mexico 3650'
    },
    {
      icon: 'rss',
      main_type: 'wireless',
      main_name: 'Wireless',
      sub_type: 'mexico900',
      sub_name: 'Mexico 900'
    },
    {
      icon: 'rss',
      main_type: 'wireless',
      main_name: 'Wireless',
      sub_type: 'mexicoLTE',
      sub_name: 'Mexico LTE'
    },
    {
      icon: 'rss',
      main_type: 'wireless',
      main_name: 'Wireless',
      sub_type: 'kingdomcity',
      sub_name: 'Kingdom City'
    }
  ]
)

IpRange.create(
  [
    { network: '192.168.82.1/24',    gateway: '192.168.82.1',   service_id: 2 },
    { network: '192.168.83.1/24',    gateway: '192.168.83.1',   service_id: 2 },
    { network: '192.168.84.1/24',    gateway: '192.168.84.1',   service_id: 2 },
    { network: '192.168.85.1/24',    gateway: '192.168.85.1',   service_id: 9 },
    { network: '192.168.86.1/24',    gateway: '192.168.86.1',   service_id: 8 },
    { network: '192.168.23.1/25',   gateway: '192.168.123.1',   service_id: 1 },
    { network: '192.168.23.128/25', gateway: '192.168.123.129', service_id: 3 }
  ]
)

IpRange.all.each do |range|
  ary = NetAddr::CIDR.create(range.network).enumerate
  ary.shift(2)
  ary.pop(1)
  ary.each do |ip_addr|
    IpAddress.create(
      ip_range_id: range.id,
      customer_id: nil,
      ip: ip_addr,
      reserved: false
    )
  end
end

num = 1
5.times do
  c = Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    home_phone: Faker::PhoneNumber.phone_number,
    ip_address_id: num,
    notes: Faker::Lorem.paragraph,
    email: Faker::Internet.safe_email,
    active: true
  )

  if num.odd?
    AddressBook.create(
      customer_id: c.id,
      address_1: Faker::Address.street_address,
      address_2: '',
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip
    )
  else
    a = AddressBook.create(
      company_id: nil,
      address_1: Faker::Address.street_address,
      address_2: '',
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip
    )

    comp = Company.create(
      customer_id: c.id,
      name: Faker::Company.name,
      contact_first_name: Faker::Name.first_name,
      contact_last_name: Faker::Name.last_name,
      contact_email: Faker::Internet.safe_email,
      billing_email: Faker::Internet.safe_email,
      address_book_id: a.id,
      main_number: Faker::PhoneNumber.phone_number,
      contact_number: Faker::PhoneNumber.phone_number,
      fax: Faker::PhoneNumber.phone_number
    )

    a.company_id = comp.id
    a.save
  end

  Webspace.create(
    customer_id: c.id,
    active: true,
    url: 'http://username.example.com',
    username: 'username',
    password: 'password'
  ) if num == 3

  Lease.create(
    customer_id: c.id,
    modem_manufacturer: 'Westell',
    modem_model: '327W',
    modem_serial: Faker::Crypto.md5,
    modem_mac: Faker::Internet.mac_address,
    tr069: true
  ) if num == 1

  Lease.create(
    customer_id: c.id,
    router_manufacturer: 'Comtrend',
    router_model: 'AR-531U',
    router_serial: Faker::Crypto.md5,
    router_mac: Faker::Internet.mac_address,
    tr069: true
  ) if num == 3
  num += 1
end
