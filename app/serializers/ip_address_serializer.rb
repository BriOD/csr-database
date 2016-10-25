class IpAddressSerializer < ActiveModel::Serializer
  attributes :id, :ip, :reserved

  has_one :customer
end
