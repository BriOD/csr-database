# ==============================================================================
# Company Table
#
# name, contact_first_name, contact_last_name, contact_email, billing_email,
# address_book_id, main_number, contact_number, fax
# ==============================================================================
class Company < ApplicationRecord
  validates :main_number, allow_blank: true, numericality: { only_integer: true }
  validates :contact_number, numericality: { only_integer: true }
  validates :fax, allow_blank: true, numericality: { only_integer: true }

  belongs_to :customer
  belongs_to :address_book
end
