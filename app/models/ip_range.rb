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
            format: { multiline: true, with: @network_regex }

  validates :gateway,
            presence: true,
            format: { multiline: true, with: @ip_regex }

  validate :unique_ips?

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

  def create_ip_addresses
    ip_ary = NetAddr::CIDR.create(network).enumerate
    ip_ary.shift(2) # Removes the first two addresses that cannot be assigned
    ip_ary.pop(1) # Remove the last address that cannot be assigned
    ip_ary.each do |ip_addr|
      IpAddress.create(
        ip_range_id: id,
        customer_id: nil,
        ip: ip_addr,
        reserved: false
      )
    end
  end

  private

  def unique_ips?
    network_ranges = IpRange.all.map { |range| range.network }
    gateway_ranges = IpRange.all.map { |range| range.gateway }
    errors.add(:base, 'must have a unique ip range') if network_ranges.include?(network)
    errors.add(:base, 'must have a unique ip gateway') if gateway_ranges.include?(gateway)
  end
end
