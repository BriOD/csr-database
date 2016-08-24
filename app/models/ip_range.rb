# ==============================================================================
# IP_Ranges Table
#
# id, network, gateway, service_id
# ==============================================================================
class IpRange < ApplicationRecord
  include IP # Includes custom class methods
  belongs_to :service
  has_many :ip_addresses
  has_many :customers, through: :ip_addresses

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

  def subnet_mask
    NetAddr::CIDR.create(self.network).wildcard_mask
  end

  def unassigned
    ip_addresses.where(reserved: false).count
  end

  def assigned
    ip_addresses.where(reserved: true).count
  end

  def percentage_used
    return 0 if assigned.zero?
    (assigned.to_f / ip_addresses.all.size.to_f * 100).to_i
  end
end
