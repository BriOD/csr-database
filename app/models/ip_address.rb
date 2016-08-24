# ==============================================================================
# IP_Address Table
#
# ip_range_id, customer_id, ip, reserved
# ==============================================================================
class IpAddress < ApplicationRecord
  belongs_to :ip_range
  has_one :customer

  validates_uniqueness_of :ip
end
