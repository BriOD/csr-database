# IP Address Controller
class IpaddressesController < ApplicationController
  # Read
  def show
    @ip_address = IpAddress.find(params[:id])
    @ip_range = @ip_address.ip_range
    @customer = @ip_address.customer || Customer.new

    @company = @customer.company || @customer.build_company
    @company_address = @company.company_address || AddressBook.new
  end
end
