User Structure
= ID (primary_key)
= First Name
= Last Name
= Email
= Password
= Account Level

Services
= ID (primary_key)
= Type
= Subtype
= Name
= SubName
= Icon

IP Ranges
= Range_ID (ip2long, primary key)
= Network
= Subnet
= Gateway
= Service_Type

IP Range Table
= ID (ip2long, primary_key)
= Range_ID (ip2long, foreign_key)
= IP_Address
= User_ID
= Reserved

Customer
= ID
= IP_Range_ID
= First Name
= Last Name
= Company
= Address 1
= Address 2
= City
= State
= Zip
= Home_Phone
= Cell_Phone
= Work_Phone
= Notes
= TDNP (boolean)
= Lease (boolean)

Customer_Other
= ID
= IP_Range_ID
= Webspace (boolean)
= Web_URL
= Web_User
= Web_Pass
= Email
= Company_First_Name
= Company_Last_Name
= Company_Email
= Company_Billing_email
= Company_Contact_Email
= Company_Address1
= Company_Address2
= Company_City
= Company_State
= Company_Zip
= Company_Phone
= Company_Contact
= Company_Fax

Lease
= ID
= IP_Range_ID
= Modem_Manufacturer
= Modem_Model
= Modem_Serial
= Modem_MAC
= Router_Manufacturer
= Router_Model
= Router_Serial
= Router_MAC
= TR-069