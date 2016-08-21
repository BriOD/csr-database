# ==============================================================================
# IP_Ranges Table
#
# id, network, gateway, service_id
# ==============================================================================
class IpRange < ApplicationRecord
  include Ip # Includes custom class methods
end
