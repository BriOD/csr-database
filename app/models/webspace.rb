# ==============================================================================
# Webspace Table
#
# customer_id, active, url, username, password
# ==============================================================================
class Webspace < ApplicationRecord
  belongs_to :customer

  validates_presence_of :url, :username, :password
end
