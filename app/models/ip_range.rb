# ==============================================================================
# IP_Ranges Table
#
# network, gateway, service_id
# ==============================================================================
class IpRange < ApplicationRecord
  belongs_to :service
  has_many :ip_addresses
  has_many :customers, through: :ip_addresses

  @ip_regex = %r{^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$}
  @network_regex = %r{^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))$}

  validates :network,
            presence: true,
            uniqueness: true,
            format: { multiline: true, with: @network_regex }

  validates :gateway,
            presence: true,
            uniqueness: true,
            format: { multiline: true, with: @ip_regex }

  validates_presence_of :service_id

  def name
    NetAddr::CIDR.create(network).network
  end

  def subnet_mask
    NetAddr::CIDR.create(network).wildcard_mask
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
