# IP Address Controller
class IpaddressesController < ApplicationController
  # Read
  def show
    @ip_address = IpAddress.find(params[:id])
    @ip_range = @ip_address.ip_range
    @customer = @ip_address.customer || @ip_address.build_customer

    @company = @customer.company || @customer.build_company
    @company_address = @company.company_address || @company.build_company_address

    respond_to do |format|
      format.html { render :show }
      format.json {
        render json: @ip_address,
               include:
                 [
                   'customer',
                   'customer.address_book',
                   'customer.company',
                   'customer.comapny.company_address',
                   'customer.webspace',
                   'customer.lease'
                 ]
      }
    end
  end

  def show_unassigned
    @results = IpAddress.order(:id).includes(:ip_range).includes(:customer).where(reserved: false)
    render json: @results
  end
end
