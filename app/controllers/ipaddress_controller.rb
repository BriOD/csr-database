class IpaddressController < ApplicationController
  # Create
  def new
  end

  def create
  end

  # Read
  def show
    @ip_address = IpAddress.find(params[:id])
    @ip_range = @ip_address.ip_range
    @customer = @ip_address.customer || Customer.new

    @company = @customer.company || @customer.build_company
    @company_address = @company.address_book || @company.build_address_book
  end

  # Update
  def edit
  end

  def update
  end

  # Destroy
  def destroy
  end
end
