# ==============================================================================
# Services Table
#
# id, icon, main_type, main_name, sub_type, sub_name
# ==============================================================================
class Service < ApplicationRecord
  validates_presence_of :icon, :main_type, :main_name
  validates_uniqueness_of :sub_type, :sub_name, scope: :main_type

  has_many :ip_ranges
  has_many :ip_addresses, through: :ip_ranges

  def name
    sub_name || main_name
  end
end
