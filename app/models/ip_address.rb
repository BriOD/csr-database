class IpAddress < ApplicationRecord
  belongs_to :ip_range
  # has_one :customer

  validates_uniqueness_of :ip
end
