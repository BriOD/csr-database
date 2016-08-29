class WebspacesController < ApplicationController
  def create
    webspace = Webspace.new(webspace_params)

    if webspace.save
      customer = webspace.customer
      flash[:notice] = 'Webspace information has been updated successfully'
      redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
    else
      flash[:error] = webspace.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    webspace = Webspace.find(params[:id])

    if webspace.update(webspace_params)
      customer = webspace.customer
      flash[:notice] = 'Webspace information has been updated successfully'
      redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
    else
      flash[:error] = webspace.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def webspace_params
    params.require(:webspace).permit(:url, :username, :password, :customer_id)
  end
end
