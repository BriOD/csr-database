module IprangeHelper
  def make_tdnp_button(customer)
    if customer.nil?
      content_tag(:button, 'Disconnect', class: 'btn btn-sm btn-block btn-secondary disabled')
    elsif customer.active
      content_tag(:button, 'Disconnect', class: 'btn btn-sm btn-block btn-danger TDNP')
    else
      content_tag(:button, 'Reconnect', class: 'btn btn-sm btn-block btn-success TDNP')
    end
  end

  def make_range_table_entry(ip_address)
    customer = ip_address.customer

    if customer.nil?
      content_tag(:tr) do
        content_tag :td, link_to(ip_address.ip, iprange_ipaddress_path(ip_address.ip_range, ip_address))
        content_tag :td, '----', class: 'hidden-xs'
        content_tag :td, 'Unassigned'
        content_tag :td, '----'
        content_tag :td, make_tdnp_button(customer)
      end
    else
      content_tag(:tr, class: ('tdnp' unless customer.active)) do
        content_tag :td, link_to(ip_address.ip, iprange_ipaddress_path(ip_address.ip_range, ip_address))
        content_tag :td, customer.account_number, class: 'hidden-xs'
        content_tag :td, customer.name
        content_tag :td, number_to_phone(customer.home_phone, area_code: true)
        content_tag :td, make_tdnp_button(customer)
      end
    end
  end
end
