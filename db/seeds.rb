Service.create(
  [
    {
      icon: 'ban',
      main_type: 'unassigned',
      main_name: 'Unassigned'
    },
    {
      icon: 'hdd-o',
      main_type: 'other',
      main_name: 'Other'
    },
    {
      icon: 'desktop',
      main_type: 'dsl',
      main_name: 'DSL'
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
      main_type: 'wireless3650',
      main_name: 'Wireless 3650',
      sub_type: 'centralia',
      sub_name: 'Centralia 3650'
    },
    {
      icon: 'rss',
      main_type: 'wireless3650',
      main_name: 'Wireless 3650',
      sub_type: 'fulton',
      sub_name: 'Fulton 3650'
    },
    {
      icon: 'rss',
      main_type: 'wireless900',
      main_name: 'Wireless 900',
      sub_type: 'fulton',
      sub_name: 'Fulton 900'
    },
    {
      icon: 'rss',
      main_type: 'wireless3650',
      main_name: 'Wireless 3650',
      sub_type: 'mexico',
      sub_name: 'Mexico 3650'
    },
    {
      icon: 'rss',
      main_type: 'wireless900',
      main_name: 'Wireless 900',
      sub_type: 'mexico',
      sub_name: 'Mexico 900'
    },
    {
      icon: 'rss',
      main_type: 'wirelesslte',
      main_name: 'Wireless LTE',
      sub_type: 'mexico',
      sub_name: 'Mexico LTE'
    },
    {
      icon: 'rss',
      main_type: 'wireless',
      main_name: 'Kingdom City',
      sub_type: 'kingdomcity',
      sub_name: 'Kingdom City'
    },
    {
      icon: 'home',
      main_type: 'other',
      main_name: 'Tanglewood',
      sub_type: 'tanglewood',
      sub_name: 'Tanglewood'
    }
  ]
)

IpRange.create(
  [
    { network: '240.88.176.156/24', gateway: '240.88.176.1', service_id: 5 },
    { network: '32.178.93.237/24', gateway: '32.178.93.1', service_id: 9 },
    { network: '16.89.154.225/24', gateway: '16.89.154.1', service_id: 3 },
    { network: '19.184.2.181/26', gateway: '19.184.2.129', service_id: 8 },
    { network: '10.174.77.173/28', gateway: '10.174.77.161', service_id: 7 },
    { network: '79.216.223.43/26', gateway: '79.216.223.1', service_id: 7 },
    { network: '165.103.176.13/27', gateway: '165.103.176.1', service_id: 3 },
    { network: '35.192.106.249/29', gateway: '35.192.106.249', service_id: 3 },
    { network: '15.121.181.185/28', gateway: '15.121.181.177', service_id: 9 },
    { network: '190.56.3.170/24', gateway: '190.56.3.1', service_id: 5 },
    { network: '123.41.92.175/24', gateway: '123.41.92.1', service_id: 2 },
    { network: '65.35.252.103/24', gateway: '65.35.252.1', service_id: 9 },
    { network: '232.29.21.253/24', gateway: '232.29.21.1', service_id: 4 },
    { network: '86.176.22.186/25', gateway: '86.176.22.129', service_id: 5 },
    { network: '220.78.128.16/25', gateway: '220.78.128.1', service_id: 3 },
    { network: '170.145.156.13/24', gateway: '170.145.156.1', service_id: 7 },
    { network: '163.65.138.119/25', gateway: '163.65.138.1', service_id: 14 },
    { network: '45.118.19.96/26', gateway: '45.118.19.65', service_id: 6 },
    { network: '50.161.204.143/24', gateway: '50.161.204.1', service_id: 3 },
    { network: '88.112.14.126/27', gateway: '88.112.14.97', service_id: 3 },
    { network: '92.136.16.173/26', gateway: '92.136.16.129', service_id: 11 },
    { network: '28.25.36.25/27', gateway: '28.25.36.1', service_id: 13 },
    { network: '139.53.119.57/26', gateway: '139.53.119.1', service_id: 12 },
    { network: '248.109.57.174/28', gateway: '248.109.57.161', service_id: 2 },
    { network: '251.159.81.196/28', gateway: '251.159.81.193', service_id: 3 },
    # Blank IP Ranges
    { network: '108.236.156.4/24', gateway: '108.236.156.1', service_id: 1 },
    { network: '242.52.15.153/24', gateway: '242.52.15.1', service_id: 1 },
    { network: '179.221.58.185/24', gateway: '179.221.58.1', service_id: 1 }
  ]
)

IpRange.all.each do |range|
  ary = NetAddr::CIDR.create(range.network).enumerate
  ary.shift(1)
  range.gateway = ary[0]
  range.save
  ary.shift(1)
  ary.pop(1)

  counter = 1
  ary.each do |ip_addr|
    cust_ip_addr = IpAddress.create(
      ip_range_id: range.id,
      customer_id: nil,
      ip: ip_addr,
      reserved: false
    )

    next if range.service_id == 1

    next if rand(1..20) < 9

    addr = AddressBook.create(
      address_1: Faker::Address.street_address,
      address_2: '',
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip
    )

    c = Customer.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      home_phone: Faker::Number.number(10),
      account_number: Faker::Number.number(9),
      ip_address_id: cust_ip_addr.id,
      address_book_id: addr.id,
      notes: Faker::Lorem.paragraph,
      email: Faker::Internet.safe_email,
      active: true
    )

    c.active = false if rand(1..20) < 3
    c.save

    cust_ip_addr.customer_id = c.id
    cust_ip_addr.reserved = true
    cust_ip_addr.save

    company_addr = AddressBook.create(
      address_1: Faker::Address.street_address,
      address_2: '',
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip
    ) if (counter % 7).zero?

    c.create_company(
      address_book_id: company_addr.id,
      name: Faker::Company.name,
      contact_first_name: Faker::Name.first_name,
      contact_last_name: Faker::Name.last_name,
      contact_email: Faker::Internet.safe_email,
      billing_email: Faker::Internet.safe_email,
      main_number: Faker::Number.number(10),
      contact_number: Faker::Number.number(10),
      fax: Faker::Number.number(10)
    ) if (counter % 7).zero?

    Webspace.create(
      customer_id: c.id,
      active: true,
      url: 'http://username.example.com',
      username: 'username',
      password: 'password'
    ) if (counter % 5).zero?

    Lease.create(
      customer_id: c.id,
      modem_manufacturer: 'Westell',
      modem_model: '327W',
      modem_serial: Faker::Crypto.md5,
      modem_mac: Faker::Internet.mac_address,
      tr069: true
    ) if (counter % 3).zero? && counter.even?

    Lease.create(
      customer_id: c.id,
      router_manufacturer: 'Comtrend',
      router_model: 'AR-531U',
      router_serial: Faker::Crypto.md5,
      router_mac: Faker::Internet.mac_address,
      tr069: true
    ) if (counter % 3).zero? && counter.odd?
    counter += 1
  end
end
