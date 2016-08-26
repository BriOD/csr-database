# IP Range Controller
class IprangesController < ApplicationController
  def show
    @range = IpRange.find(params[:id])
  end
end
