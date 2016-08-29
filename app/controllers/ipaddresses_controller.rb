# IP Address Controller
class IpaddressesController < ApplicationController
  # Read
  def show
    @ip_address = IpAddress.find(params[:id])
    @ip_range = @ip_address.ip_range
    @customer = @ip_address.customer || @ip_address.build_customer

    @company = @customer.company || @customer.build_company
    @company_address = @company.company_address || @company.build_company_address
  end
end
