class IpaddressController < ApplicationController
  # Create
  def new
  end

  def create
  end

  # Read
  def show
    @ip_address = IpAddress.find(params[:id])
    @customer = @ip_address.customer

    @customer.new if @customer.nil?
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
