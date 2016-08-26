module IpaddressHelper
  def ipaddress_widget_title(ip_addr)
    if ip_addr.customer.nil?
      return ip_addr.ip
    else
      return ip_addr.customer.name
    end
  end
end
