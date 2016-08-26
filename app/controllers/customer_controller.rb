class CustomerController < ApplicationController
  def destroy
    @customer = Customer.find(params[:id])

    # @customer.company.destroy unless @customer.company.nil?
    # @customer.lease.destroy unless @customer.lease.nil?
    # @customer.webspace.destroy unless @customer.webspace.nil?

    redirect_to :back
  end

  def move
    @customer = Customer.find(params[:id])

    redirect_to iprange_ipaddress(@customer.ip_range, @customer.ip_address)
  end
end
