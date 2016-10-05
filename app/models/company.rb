# ==============================================================================
# Company Table
#
# name, contact_first_name, contact_last_name, contact_email, billing_email,
# address_book_id, main_number, contact_number, fax
# ==============================================================================
class Company < ApplicationRecord
  belongs_to :customer
  belongs_to :company_address, class_name: 'AddressBook', foreign_key: 'address_book_id'
  accepts_nested_attributes_for :company_address

  validates :contact_number, length: { minimum: 10, maximum: 10 }, numericality: { only_integer: true, message: 'must be filled in' }
  validates :main_number, length: { minimum: 10, maximum: 10 }, allow_blank: true, numericality: { only_integer: true }
  validates :fax, length: { minimum: 10, maximum: 10 }, allow_blank: true, numericality: { only_integer: true }

  NULL_ATTRS = %w(name contact_last_name contact_last_name contact_email billing_email main_number contact_number fax)
  before_validation :blank_if_nil

  def blank_if_nil
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end

  def main_number=(val)
    self['main_number'] = strip_phone(val)
  end

  def contact_number=(val)
    self['contact_number'] = strip_phone(val) unless val.nil?
  end

  def fax=(val)
    self['fax'] = strip_phone(val) unless val.nil?
  end

  def strip_phone(phone_number)
    phone_number.gsub(/\D/, '')
  end

  def self.empty_params?(params)
    params[:customer][:company_attributes][:name].empty? &&
      params[:customer][:company_attributes][:contact_first_name].empty?
  end
end
