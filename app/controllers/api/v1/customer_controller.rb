class Api::V1::CustomersController < ApplicationController
  before_action :set_api_v1_customers, only: [:show]
  
  respond_to :json
  
  def index
    @customers = Customer.order(:id)
    
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @customers }
    end
  end
  
  def show
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @api_v1_customers }
    end
  end
  
  private
  
  def set_api_v1_customers
    @api_v1_customers = Customer.find(params[:id])
  end
end