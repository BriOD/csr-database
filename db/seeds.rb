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
    {
      network: '198.153.82.1/24',
      gateway: '198.153.82.1',
      service_id: 2
    },
    {
      network: '198.153.83.1/24',
      gateway: '198.153.83.1',
      service_id: 2
    },
    {
      network: '198.153.84.1/24',
      gateway: '198.153.84.1',
      service_id: 2
    },
    {
      network: '198.153.85.1/24',
      gateway: '198.153.85.1',
      service_id: 7
    },
    {
      network: '198.153.86.1/24',
      gateway: '198.153.86.1',
      service_id: 8
    },
    {
      network: '192.69.123.1/25',
      gateway: '192.69.123.1',
      service_id: 2
    },
    {
      network: '192.69.123.128/25',
      gateway: '192.69.123.129',
      service_id: 9
    }
  ]
)
