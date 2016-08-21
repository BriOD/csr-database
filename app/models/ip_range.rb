# ==============================================================================
# IP_Ranges Table
#
# id, network, gateway, service_id
# ==============================================================================
class IpRange < ApplicationRecord
  include IP # Includes custom class methods

  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  @network_regex = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))$/

  validates :network,
            presence: true,
            uniqueness: true,
            format: { multiline: true, with: @network_regex }

  validates :gateway,
            presence: true,
            uniqueness: true,
            format: { multiline: true, with: @ip_regex }

  validates_presence_of :service_id
end
