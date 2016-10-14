class Api::V1::WebspacesController < ApplicationController
  before_action :set_api_v1_webspaces, only: [:show]
  
  respond_to :json
  
  def index
    @webspaces = Webspace.order(:id)
    
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @webspaces }
    end
  end
  
  def show
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @api_v1_webspaces }
    end
  end
  
  private
  
  def set_api_v1_webspaces
    @api_v1_webspaces = Webspace.find(params[:id])
  end
end