class Customer < ApplicationRecord
  belongs_to :ip_address
  belongs_to :address_book

  has_one :webspace
  has_one :company
  has_one :lease

  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :home_phone, numericality: { only_integer: true }
  validates :cell_phone, allow_blank: true, numericality: { only_integer: true }
  validates :work_phone, allow_blank: true, numericality: { only_integer: true }
  
  validate :name?

  def name?
    if first_name.nil? && last_name.nil? && company.nil?
      errors.add(:name, 'You must have either a first and last name or company')
    end
  end
end
