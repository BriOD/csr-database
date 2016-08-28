# Customers Controller
class CustomersController < ApplicationController
  def update
    @customer = Customer.find(params[:id])

    # raise

    @customer.update(customer_params)
    redirect_to iprange_ipaddress_path(@customer.ip_range, @customer.ip_address)
  end

  def destroy
    @customer = Customer.find(params[:id])

    # @customer.company.destroy unless @customer.company.nil?
    # @customer.lease.destroy unless @customer.lease.nil?
    # @customer.webspace.destroy unless @customer.webspace.nil?

    redirect_to :back
  end

  def move
    @customer = Customer.find(params[:id])

    redirect_to iprange_ipaddress_path(@customer.ip_range, @customer.ip_address)
  end

  def tdnp
    @customer = Customer.find(params[:id])
    @customer.update(active: @customer.active.!)

    redirect_to :back
  end

  private

  def customer_params
    params.require(:customer).permit(
      :first_name, :last_name, :email,
      :home_phone, :cell_phone, :work_phone,
      :notes,
      company: [
        :name, :contact_first_name, :contact_last_name, :billing_email,
        :contact_email, :main_number, :contact_number, :fax,
        address_book: [:address_1, :address_2, :city, :state, :zipcode]
      ],
      address_book: [:address_1, :address_2, :city, :state, :zipcode],
      lease: [
        :modem_manufacturer, :modem_model, :modem_serial, :modem_mac,
        :router_manufacturer, :router_model, :router_serial, :router_mac,
      ],
      webspace: [:url, :username, :password]
    )
  end
end
