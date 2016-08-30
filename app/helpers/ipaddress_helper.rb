module IpaddressHelper
  def ipaddress_widget_title(ip_addr)
    if ip_addr.customer.nil?
      return ip_addr.ip
    else
      return ip_addr.customer.name
    end
  end

  def encode_address(customer)
    if customer.nil? || customer.id.nil?
      '211 South Main Street, Auxvasse, MO 65231'
    else
      encoded_address = customer.address_book.address_1.to_s

      unless customer.address_book.address_2.empty?
        encoded_address + ", #{customer.address_book.address_2}"
      end

      encoded_address += ", #{customer.address_book.city}"
      encoded_address += ", #{customer.address_book.state}"
      encoded_address += ", #{customer.address_book.zipcode}"

      encoded_address
    end
  end
end
