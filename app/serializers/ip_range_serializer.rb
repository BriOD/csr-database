class IpRangeSerializer < ActiveModel::Serializer
  attributes :id, :network, :gateway
  
  has_many :ip_addresses
end
