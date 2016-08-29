# Customers Controller
class CustomersController < ApplicationController
  def create
    @customer = Customer.new

    if params[:customer][:company_attributes][:name].empty? &&
       params[:customer][:company_attributes][:contact_first_name].empty?
      @customer.update(customer_params)
    else
      @customer.update(customer_company_params)
    end

    if @customer.save
      flash[:notice] = 'Customer information has been updated successfully'
      redirect_to iprange_ipaddress_path(@customer.ip_range, @customer.ip_address)
    else
      flash[:error] = @customer.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @customer = Customer.find(params[:id])

    if params[:customer][:company_attributes][:name].empty? &&
       params[:customer][:company_attributes][:contact_first_name].empty?
      @customer.update(customer_params)
    else
      @customer.update(customer_company_params)
    end

    if params[:lease_checkbox].nil? && !@customer.lease.nil?
      @customer.lease.destroy
    end

    if params[:webspace].nil? && !@customer.webspace.nil?
      @customer.webspace.destroy
    end

    if @customer.errors.empty?
      flash[:notice] = 'Customer information has been updated successfully'
      redirect_to iprange_ipaddress_path(@customer.ip_range, @customer.ip_address)
    else
      flash[:error] = @customer.errors.full_messages
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
    @customer = Customer.find(params[:id])

    raise

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
