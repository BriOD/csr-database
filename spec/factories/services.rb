FactoryGirl.define do
  factory :service do |f|
    f.service_icon 'signal'
    f.service_type 'wifi'
    f.service_name 'WiFi'
    f.sub_service_type 'bentoncity'
    f.sub_service_type 'Benton City'
  end
end
