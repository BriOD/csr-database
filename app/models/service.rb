# ==============================================================================
# Services Table
#
# icon, main_type, main_name, sub_type, sub_name
# ==============================================================================
class Service < ApplicationRecord
  validates_presence_of :icon, :main_type, :main_name
  validates_uniqueness_of :sub_type, :sub_name, scope: :main_type

  has_many :ip_ranges
  has_many :ip_addresses, through: :ip_ranges
  has_many :customers, through: :ip_ranges

  def name
    sub_name || main_name
  end

  def self.main_types
    all.map {|serv| serv.main_type}.uniq
  end

  def self.sub_types(main_type)
    all.map { |serv| serv.sub_type if serv.main_type == main_type }.uniq.reject(&:nil?)
  end

  def self.main_type_ids

  end


  def self.sub_type_ids(main_type)

  end
end
