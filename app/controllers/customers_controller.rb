# Customers Controller
class CustomersController < ApplicationController
  def update
    @customer = Customer.find(params[:id])

    raise

    @customer.update(customer_params)

    if (params[:lease_checkbox] == on)
      @lease = Lease.find_by(customer_id: params[:id]) || Lease.new
    end

    if (params[:webspace_checkbox] == on)
      @webspace = Webspace.find_by(customer_id: params[:id]) || Webspace.new
    end
    redirect_to iprange_ipaddress_path(@customer.ip_range, @customer.ip_address)
  end

  def destroy
    @customer = Customer.find(params[:id])
    ip_range = @customer.ip_range
    ip_address = @customer.ip_address

    @customer.company.address_book.destroy unless @customer.company.nil?
    @customer.company.destroy unless @customer.company.nil?
    @customer.lease.destroy unless @customer.lease.nil?
    @customer.webspace.destroy unless @customer.webspace.nil?
    @customer.address_book.destroy unless @customer.nil?
    @customer.destroy

    redirect_to iprange_ipaddress_path(ip_range, ip_address)
  end

  def move
    @customer = Customer.find(params[:id])

    redirect_to iprange_ipaddress_path(@customer.ip_range, @customer.ip_address)
  end

  def tdnp
    @customer = Customer.find(params[:id])
    @customer.update(active: @customer.active.!)

    redirect_back(fallback_location: root_path)
  end

  private

  def customer_params
    params.require(:customer).permit(
      :first_name, :last_name, :email,
      :home_phone, :cell_phone, :work_phone,
      :notes, :lease_checkbox, :webspace_checkbox,
      company: [
        :name, :contact_first_name, :contact_last_name, :billing_email,
        :contact_email, :main_number, :contact_number, :fax,
        address_book: [:address_1, :address_2, :city, :state, :zipcode]
      ],
      address_book: [:address_1, :address_2, :city, :state, :zipcode],
    )
  end
end
