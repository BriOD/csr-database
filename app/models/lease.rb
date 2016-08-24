# ==============================================================================
# Lease Table
#
# customer_id, modem_manufacturer, modem_model, modem_serial, modem_mac,
# router_manufacturer, router_model, router_serial, tr069
# ==============================================================================
class Lease < ApplicationRecord
  belongs_to :customer
end
