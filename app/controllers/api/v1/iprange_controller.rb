class Api::V1::IpaddressesController < ApplicationController
  before_action :set_api_v1_ipaddresses, only: [:show]
  
  respond_to :json
  
  def index
    @ip_addresses = IpAddress.order(:id).includes(:ip_range).includes(:customer)
    
    respond_to do |f|
      f.html { render :show }
      f.json { 
        render json: @ip_addresses,
        include: ['customer']
      }
    end
  end
  
  def show
    @ip_address = IpAddress.find(params[:id])
    @ip_range = @ip_address.ip_range
    @customer = @ip_address.customer || @ip_address.build_customer

    @company = @company || @build_company
    @company_address = @company.company_address || @company.build_company_address unless @company.nil?
    
    respond_to do |f|
      f.html { render :show }
      f.json {
        render json: @customer,
        include: ['address_book',
                  'company',
                  'company.company_address',
                  'lease',
                  'webspace'
                 ]
      }
    end
  end
  
  private
  
  def set_api_v1_ipaddresses
    @api_v1_ipaddress = IpAddress.find(params[:id])
  end
end