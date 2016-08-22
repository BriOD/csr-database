class Customer < ApplicationRecord
  belongs_to :ip_address
  belongs_to :address_book

  has_one :webspace
  has_one :company
  has_one :lease

  validates_presence_of :address_book_id
  validate :name?

  def name?
    if first_name.nil? && last_name.nil? && company.nil?
      errors.add(:name, 'You must have either a first and last name or company')
    end
  end
end
