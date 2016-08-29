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
  validates :home_phone, numericality: { only_integer: true, message: 'must be filled in' }
  validates :cell_phone, allow_blank: true, numericality: { only_integer: true }
  validates :work_phone, allow_blank: true, numericality: { only_integer: true }

  validate :name?

  NULL_ATTRS = %w(first_name last_name email home_phone cell_phone work_phone)
  before_save :blank_if_nil

  def name?
    if first_name == '' && last_name == '' && company.id == ''
      errors.add(:base, 'You must have either a first and last name or company')
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.disconnected
    where(active: false)
  end

  def blank_if_nil
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end

  def home_phone=(val)
    self['home_phone'] = strip_phone(val)
  end

  def cell_phone=(val)
    self['cell_phone'] = strip_phone(val) unless val.nil?
  end

  def work_phone=(val)
    self['work_phone'] = strip_phone(val) unless val.nil?
  end

  def strip_phone(phone_number)
    phone_number.gsub(/\D/, '')
  end
end
