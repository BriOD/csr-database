# IP Address Controller
class IpaddressesController < ApplicationController
  # Read
  def show
    @ip_address = IpAddress.find(params[:id])
    @ip_range = @ip_address.ip_range
    @customer = @ip_address.customer || @ip_address.build_customer

    @company = @company || @build_company
    @company_address = @company.company_address || @company.build_company_address
  end

  def show_unassigned
    @results = IpAddress.order(:id).includes(:ip_range).includes(:customer).where(reserved: false)
    
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @results }
    end
  end
end
