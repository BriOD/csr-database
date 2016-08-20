class Service < ApplicationRecord
  validates_presence_of :icon, :main_type, :name
  validates_uniqueness_of :sub_type, :sub_name, scope: :main_type
end
