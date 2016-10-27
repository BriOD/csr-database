class Api::V1::IpaddressesController < ApplicationController
  before_action :set_api_v1_ipaddresses, only: [:show]

  respond_to :json

  def index
    @ipaddresses = IpAddress.order(:id)
    render json: @ipaddresses, include: ['']
  end

  def show
    render json: @api_v1_ipaddress,
           include:
             [
               'customer',
               'customer.address_book',
               'customer.company',
               'customer.comapny.company_address',
               'customer.webspace',
               'customer.lease'
             ]
  end

  def show_unassigned
    results = IpAddress.order(:id).includes(:ip_range).includes(:customer).where(reserved: false)
    render json: results
  end

  private

  def set_api_v1_ipaddresses
    @api_v1_ipaddress = IpAddress.find(params[:id])
  end
end
