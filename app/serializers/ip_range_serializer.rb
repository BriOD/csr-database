class IpRangeSerializer < ActiveModel::Serializer
  attributes :id, :network, :gateway

  has_one :service
  has_many :ip_addresses
end
