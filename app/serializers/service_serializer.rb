class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :icon, :main_type, :main_name, :sub_type, :sub_name
end
