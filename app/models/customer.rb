# ==============================================================================
# Customer Table
#
# ip_address_id, address_book_id, first_name, last_name, home_phone, cell_phone
# work_phone, notes, active, email
# ==============================================================================
class Customer < ApplicationRecord
  belongs_to :ip_address
  delegate :ip_range, to: :ip_address
  delegate :service, to: :ip_range
  belongs_to :address_book

  has_one :webspace
  has_one :company
  has_one :lease

  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :address_book
  accepts_nested_attributes_for :lease
  accepts_nested_attributes_for :webspace

  validates_format_of :email, with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :home_phone, length: { minimum: 10, maximum: 10 }, numericality: { only_integer: true, message: 'must be filled in' }
  validates :cell_phone, allow_blank: true, length: { minimum: 10, maximum: 10 }, numericality: { length: 10, only_integer: true }
  validates :work_phone, allow_blank: true, length: { minimum: 10, maximum: 10 }, numericality: { length: 10, only_integer: true }

  validate :name?

  NULL_ATTRS = %w(first_name last_name email home_phone cell_phone work_phone)
  before_validation :blank_if_nil

  # ====== Validation Methods ===============
  def name?
    if company.nil? && (first_name.nil? || last_name.nil?)
      errors.add(:base, 'You must have either a first and last name or company')
    elsif !company.nil? && company.name.nil?
      errors.add(:base, 'You must have a company name')
    end
  end

  def blank_if_nil
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end

  # ====== Setter Methods ===============
  def home_phone=(val)
    self['home_phone'] = strip_phone(val)
  end

  def cell_phone=(val)
    self['cell_phone'] = strip_phone(val) unless val.nil?
  end

  def work_phone=(val)
    self['work_phone'] = strip_phone(val) unless val.nil?
  end

  # ====== Getter Methods ===============
  def name
    "#{first_name} #{last_name}"
  end

  # ====== Class Methods ===============
  def self.disconnected
    where(active: false)
  end

  # ====== Instance Methods ===============
  def strip_phone(phone_number)
    phone_number.gsub(/\D/, '')
  end

  def move(new_ip_address)
    unless ip_address.update(customer_id: nil, reserved: false)
      errors.add(:base, 'You must have a company name')
      return false
    end

    unless update(ip_address_id: new_ip_address.id)
      errors.add(:base, 'Unable to update the customer with the new IP Address')
      return false
    end

    unless ip_address.update(customer_id: id, reserved: true)
      errors.add(:base, 'Unable to update the new IP Adress')
      return false
    end
    true
  end
end
