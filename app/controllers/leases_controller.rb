# Modem/Router Lease Controller
class LeasesController < ApplicationController
  def create
  end

  def update
    lease = Lease.find(params[:id])
    customer = lease.customer

    lease.update(lease_params)

    redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
  end

  private

  def lease_params
    params.require(:lease).permit(
      :modem_manufacturer, :modem_model, :modem_serial, :modem_mac,
      :router_manufacturer, :router_model, :router_serial, :router_mac,
      :customer_id
    )
  end
end
