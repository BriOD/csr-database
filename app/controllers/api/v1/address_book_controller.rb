class Api::V1::AddressBookController < ApplicationController
  before_action :set_api_v1_address_book, only: [:show]
  
  respond_to :json
  
  def index
    @address_book = AddressBook.order(:id)
    render json: @address_book, include: ['']
  end
  
  def show
    render json: @api_v1_address_book, include: ['customer']
  end
  
  private
  
  def set_api_v1_address_book
    @api_v1_address_book = AddressBook.find(params[:id])
  end
end