# IP Range Controller
class IprangesController < ApplicationController
  def show
    @range = IpRange.find(params[:id])
    @ip_addresses = IpAddress.order(:id).includes(:ip_range).includes(:customer).where(ip_range_id: params[:id])
    render :show
  end
end
