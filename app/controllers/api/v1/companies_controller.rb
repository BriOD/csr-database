class Api::V1::CompaniesController < ApplicationController
  before_action :set_api_v1_companies, only: [:show]
  
  respond_to :json
  
  def index
    @companies = Company.order(:id)
    
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @companies }
    end
  end
  
  def show
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @api_v1_companies }
    end
  end
  
  private
  
  def set_api_v1_companies
    @api_v1_companies = Company.find(params[:id])
  end
end