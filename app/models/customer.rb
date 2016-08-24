# ==============================================================================
# Customer Table
#
# ip_address_id, address_book_id, first_name, last_name, home_phone, cell_phone
# work_phone, notes, active, email
# ==============================================================================
class Customer < ApplicationRecord
  # include Phone
  belongs_to :ip_address
  belongs_to :address_book

  has_one :webspace
  has_one :company
  has_one :lease

  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :home_phone, numericality: { only_integer: true }
  validates :cell_phone, allow_blank: true, numericality: { only_integer: true }
  validates :work_phone, allow_blank: true, numericality: { only_integer: true }

  # validate :name?

  # def name?
  #   if first_name.nil? && last_name.nil? && company.nil?
  #     errors.add(:base, 'You must have either a first and last name or company')
  #   end
  # end

  def name
    "#{first_name} #{last_name}"
  end

  def home_phone
    # number_to_phone(home_phone, area_code: true)
  end

  def self.disconnected
    where(active: false)
  end
end
