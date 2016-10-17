class Api::V1::LeasesController < ApplicationController
  before_action :set_api_v1_lease, only: [:show]
  
  respond_to :json
  
  def index
    @leases = Lease.order(:id)
    render json: @leases, include: ['']
  end
  
  def show
    render json: @api_v1_lease, include: ['customer']
  end
  
  private
  
  def set_api_v1_lease
    @api_v1_lease = Lease.find(params[:id])
  end
end