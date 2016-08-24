# ==============================================================================
# IP_Address Table
#
# ip_range_id, customer_id, ip, reserved
# ==============================================================================
class IpAddress < ApplicationRecord
  belongs_to :ip_range
  belongs_to :customer

  validates_uniqueness_of :ip
end
