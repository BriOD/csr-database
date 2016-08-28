module IprangeHelper
  def make_tdnp_button(customer)
    if customer.nil? || customer.id.nil?
      content_tag(:button, 'Disconnect', class: 'btn btn-sm btn-block btn-secondary disabled')
    elsif customer.active
      link_to 'Disconnect', customer_tdnp_path(customer), class: 'btn btn-danger btn-block TDNP'
    else
      link_to 'Reconnect', customer_tdnp_path(customer), class: 'btn btn-success btn-block TDNP'
    end
  end

  def make_table_link(ip_addr)
    link_to(ip_addr.ip, iprange_ipaddress_path(ip_addr.ip_range, ip_addr))
  end

  def make_range_table_entry(ip_addr)
    customer = ip_addr.customer

    if customer.nil?
      content_tag(:tr) do
        concat(content_tag(:td, make_table_link(ip_addr)))
        concat(content_tag(:td, '----', class: 'hidden-xs'))
        concat(content_tag(:td, 'Unassigned'))
        concat(content_tag(:td, '----'))
        concat(content_tag(:td, make_tdnp_button(customer)))
      end
    else
      content_tag(:tr, class: ('tdnp' unless customer.active)) do
        concat(content_tag(:td, make_table_link(ip_addr)))
        concat(content_tag(:td, customer.account_number, class: 'hidden-xs'))
        concat(content_tag(:td, customer.name))
        concat(content_tag(:td, number_to_phone(customer.home_phone, area_code: true)))
        concat(content_tag(:td, make_tdnp_button(customer)))
      end
    end
  end

  def encode_address(customer)
    if customer.nil? || customer.id.nil?
      '211 South Main Street, Auxvasse, MO 65231'
    else
      address = customer.address_book.address_1.to_s

      unless customer.address_book.address_2.empty?
        address << ", #{customer.address_book.address_2}"
      end

      address << ", #{customer.address_book.city}"
      address << ", #{customer.address_book.state}"
      address << ", #{customer.address_book.zipcode}"

      address
    end
  end
end
