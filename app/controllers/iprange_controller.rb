# IP Range Controller
class IprangeController < ApplicationController
  def show
    @range = IpRange.find(params[:id])
  end
end
