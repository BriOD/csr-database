class Company < ApplicationRecord
  validates :main_number, allow_blank: true, numericality: { only_integer: true }
  validates :contact_number, numericality: { only_integer: true }
  validates :fax, allow_blank: true, numericality: { only_integer: true }

  belongs_to :customer
end
