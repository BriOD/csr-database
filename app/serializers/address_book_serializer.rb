class AddressBookSerializer < ActiveModel::Serializer
  attributes :id, :address_1, :address_2, :city, :state, :zipcode
  
  belongs_to :customer
end
