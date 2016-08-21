# ==============================================================================
# Services Table
#
# id, icon, main_type, main_name, sub_type, sub_name
# ==============================================================================
class Service < ApplicationRecord
  validates_presence_of :icon, :main_type, :main_name
  validates_uniqueness_of :sub_type, :sub_name, scope: :main_type

  def name
    sub_name || main_name
  end
end
