class Api::V1::WebspacesController < ApplicationController
  before_action :set_api_v1_webspaces, only: [:show]
  
  respond_to :json
  
  def index
    @webspaces = Webspace.order(:id)
    render json: @webspaces, include: ['']
  end
  
  def show
    render json: @api_v1_webspaces, include: ['customer']
  end
  
  private
  
  def set_api_v1_webspaces
    @api_v1_webspaces = Webspace.find(params[:id])
  end
end