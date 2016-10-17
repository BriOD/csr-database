class Api::V1::IprangesController < ApplicationController
  before_action :set_api_v1_iprange, only: [:show]
  
  respond_to :json
  
  def index
    @ipranges = IpRange.order(:id)
    render json: @ipranges, include: ['']
  end
  
  def show
    render json: @api_v1_iprange, include: ['ip_addresses']
  end
  
  private
  
  def set_api_v1_iprange
    @api_v1_iprange = IpRange.find(params[:id])
  end
end