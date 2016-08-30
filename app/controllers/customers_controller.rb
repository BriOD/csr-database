# Customers Controller
class CustomersController < ApplicationController
  def create
    customer = Customer.new

    if Company.empty_params?(params)
      customer.update(customer_params)
    else
      customer.update(customer_company_params)
    end

    if customer.save
      flash[:notice] = 'Customer information has been updated successfully'
      redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
    else
      flash[:error] = customer.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    customer = Customer.find(params[:id])

    if Company.empty_params?(params)
      customer.update(customer_params)
    else
      customer.update(customer_company_params)
    end

    if params[:lease_checkbox].nil? && !customer.lease.nil?
      customer.lease.destroy
    end

    if params[:webspace].nil? && !customer.webspace.nil?
      customer.webspace.destroy
    end

    if customer.errors.empty?
      flash[:notice] = 'Customer information has been updated successfully'
      redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
    else
      flash[:error] = customer.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    ip_range = @customer.ip_range
    ip_address = @customer.ip_address

    @customer.company.company_address.destroy unless @customer.company.nil?
    @customer.company.destroy unless @customer.company.nil?
    @customer.lease.destroy unless @customer.lease.nil?
    @customer.webspace.destroy unless @customer.webspace.nil?
    @customer.address_book.destroy unless @customer.nil?
    @customer.destroy

    redirect_to iprange_ipaddress_path(ip_range, ip_address)
  end

  def move
    customer = Customer.find(params[:id])
    new_ip_address = IpAddress.find_by(ip: params[:customer][:ip_address])

    if new_ip_address.nil?
      flash[:error] = 'Unable to find a valid IP address to move this customer to.'
      redirect_back(fallback_location: root_path)
    elsif !new_ip_address.customer_id.nil?
      flash[:error] = 'You can only move the customer to an empty IP address.'
      redirect_back(fallback_location: root_path)
    elsif customer.move(new_ip_address)
      flash[:notice] = 'Customer has been moved successfully.'
      redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
    else
      flash[:error] = 'An unknown error has occured while trying to move this customer'
      redirect_back(fallback_location: root_path)
    end
  end

  def tdnp
    customer = Customer.find(params[:id])
    customer.update(active: customer.active.!)

    redirect_back(fallback_location: root_path)
  end

  def show_tdnps
    @results = Customer.where(active: false).include([:ip_address])
  end

  private

  def customer_params
    params.require(:customer).permit(
      :first_name, :last_name, :email, :home_phone, :cell_phone, :work_phone,
      :notes, :lease_checkbox, :webspace_checkbox, :id, :ip_address_id, :account_number,
      address_book_attributes: [:id, :address_1, :address_2, :city, :state, :zipcode]
    )
  end

  def customer_company_params
    params.require(:customer).permit(
      :first_name, :last_name, :email,
      :home_phone, :cell_phone, :work_phone,
      :notes, :lease_checkbox, :webspace_checkbox, :id,
      company_attributes: [
        :name, :contact_first_name, :contact_last_name, :billing_email,
        :contact_email, :main_number, :contact_number, :fax, :id, :ip_address_id, :account_number,
        company_address_attributes: [:id, :address_1, :address_2, :city, :state, :zipcode]
      ],
      address_book_attributes: [:id, :address_1, :address_2, :city, :state, :zipcode]
    )
  end
end
