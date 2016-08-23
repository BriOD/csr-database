/range/192.168.0.0/1/
/range/[:ip_range_id]/address/[:id_address]

localhost/192.168.0.0/ => IpRange Controller

localhost/192.168.0.1/ => IpAddress Controller
localhost/192.168.2.1/
localhost/192.168.5.1/

localhost/192.168.5.1/56/ => IpAddress Controller (Customer Info Actually)


if a range does not have a service_id it is set to unassigned

eventually we would have an admin dashboard that can change the service of
each range and manipulate the ranges in other ways

User Structure [DONE]
= ID (primary_key)
= First Name
= Last Name
= Email
= Password
= Account Level

Services [DONE]
= ID (primary_key)
= Type
= Subtype
= Name
= SubName
= Icon

IP Ranges [DONE]
= Range_ID (ip2long, primary key)
= Network - '198.153.80.0/24'
= Gateway - '198.153.80.1'
= Service_ID - 3 (DSL)

IP Range Table [DONE]
= ID (ip2long, primary_key)
= Range_ID (ip2long, foreign_key)
= IP_Address
= Customer_ID
= Reserved

Customer
t.integer :ip_range_id
t.string :first_name
t.string :last_name
t.integer :home_phone
t.integer :cell_phone
t.integer :work_phone
t.text :notes
t.boolean :active, default: false
t.string :email
t.integer :lease_id
t.integer :company_id
t.integer :webspace_id
t.integer :address_book_id

Address_Book
t.integer :customer_id
t.integer :company_id
t.string :address_1
t.string :address_2
t.string :city
t.string :state
t.integer :zipcode

Webspace
t.integer :customer_id
t.boolean :active, default: false
t.string :url
t.string :username
t.string :password

Company
t.integer :customer_id
t.string :Name
t.string :contact_first_name
t.string :contact_last_name
t.string :contact_email
t.string :billing_email
t.integer :address_book_id
t.integer :main_number
t.integer :contact_number
t.integer :fax

Lease
t.integer :customer_id
t.string :modem_manufacturer
t.string :modem_model
t.string :modem_serial
t.string :modem_mac
t.string :router_manufacturer
t.string :router_model
t.string :router_serial
t.string :router_mac
t.string :tr069
