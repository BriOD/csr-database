# Modem/Router Lease Controller
class LeasesController < ApplicationController
  def create
    lease = Lease.new(lease_params)

    if lease.save
      customer = lease.customer
      flash[:notice] = 'Lease information has been updated successfully'
      redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
    else
      flash[:error] = lease.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    lease = Lease.find(params[:id])

    if lease.update(lease_params)
      customer = lease.customer
      flash[:notice] = 'Lease information has been updated successfully'
      redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
    else
      flash[:error] = lease.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
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
