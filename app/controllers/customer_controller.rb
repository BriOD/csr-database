class CustomerController < ApplicationController
  def destroy
    @customer = Customer.find(params[:id])
    raise @customer
  end
end
