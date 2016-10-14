class Api::V1::LeasesController < ApplicationController
  before_action :set_api_v1_leases, only: [:show]
  
  respond_to :json
  
  def index
    @leases = Lease.order(:id)
    
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @leases }
    end
  end
  
  def show
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @api_v1_leases }
    end
  end
  
  private
  
  def set_api_v1_leases
    @api_v1_leases = Lease.find(params[:id])
  end
end