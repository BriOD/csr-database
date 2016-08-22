class IpAddress < ApplicationRecord
  belongs_to :ip_range

  validates_uniqueness_of :ip
end
