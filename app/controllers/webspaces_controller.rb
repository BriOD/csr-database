class WebspacesController < ApplicationController
  def create
    webspace = Webspace.new(webspace_params)

    if webspace.save
      customer = webspace.customer
      redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    webspace = Webspace.find(params[:id])
    customer = webspace.customer

    webspace.update(webspace_params)

    redirect_to iprange_ipaddress_path(customer.ip_range, customer.ip_address)
  end

  private

  def webspace_params
    params.require(:webspace).permit(:url, :username, :password, :customer_id)
  end
end
