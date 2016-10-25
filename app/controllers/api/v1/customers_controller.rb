class Api::V1::CustomersController < ApplicationController
  before_action :set_api_v1_customer, only: [:show]

  respond_to :json

  def index
    @customers = Customer.order(:id)
    render json: @customers, include: ['']
  end

  def show
    render json: @api_v1_customer, include: ['address_book','webspace','company','lease']
  end

  def show_tdnps
    results = Customer.where(active: false).includes([:ip_address])
    render json: results, include: ['']
  end

  private

  def set_api_v1_customer
    @api_v1_customer = Customer.find(params[:id])
  end
end
