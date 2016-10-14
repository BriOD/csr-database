class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :modem_manufacturer, :modem_model, :modem_serial, :modem_mac,
             :router_manufacturer, :router_model, :router_serial, :router_mac,
             :tr069
end
