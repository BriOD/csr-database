class Api::V1::CompaniesController < ApplicationController
  before_action :set_api_v1_company, only: [:show]
  
  respond_to :json
  
  def index
    @companies = Company.order(:id)
    render json: @companies, include: ['']
  end
  
  def show
    render json: @api_v1_company, include: ['company_address','customer']
  end
  
  private
  
  def set_api_v1_company
    @api_v1_company = Company.find(params[:id])
  end
end