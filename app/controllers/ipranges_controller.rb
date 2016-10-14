# IP Range Controller
class IprangesController < ApplicationController
  def show
    @range = IpRange.find(params[:id])
    @ip_addresses = IpAddress.order(:id).includes(:ip_range).includes(:customer).where(ip_range_id: params[:id])
    
    respond_to do |f|
      f.html { render :show }
      f.json { 
        render json: @range,
        include: ['ip_addresses',
                  'ip_addresses.customer',
                  'ip_addresses.customer.address_book',
                  'ip_addresses.customer.company',
                  'ip_addresses.customer.company.company_address',
                  'ip_addresses.customer.lease',
                  'ip_addresses.customer.webspace'
                 ]
      }
    end
  end
end
