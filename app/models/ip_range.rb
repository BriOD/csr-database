# ==============================================================================
# IP_Ranges Table
#
# id, network, gateway, service_id
# ==============================================================================
class IpRange < ApplicationRecord
  include IP # Includes custom class methods
  belongs_to :service
  has_many :ip_addresses

  validates :network,
            presence: true,
            uniqueness: true

  validates :gateway,
            presence: true,
            uniqueness: true

  validates_presence_of :service_id

  def network_name
    NetAddr::CIDR.create(self.network).network
  end
end
