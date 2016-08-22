class AddressBook < ApplicationRecord
  has_one :customer
  has_one :company

  validates_presence_of :address_1, :city, :state, :zipcode
end
