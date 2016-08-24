# ==============================================================================
# AddressBook Table
#
# address_1, address_2, city, state, zipcode
# ==============================================================================
class AddressBook < ApplicationRecord
  has_one :customer
  has_one :company

  validates_presence_of :address_1, :city, :state, :zipcode
end
