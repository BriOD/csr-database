# Global Service Helper for the Sidebar and Other Partials
module ServiceHelper
  def get_sidebar_service_links(type)
    services = get_services(type)
    ranges = get_service_ranges(services).flatten
    if ranges.size > 1
      make_sidebar_submenu(ranges, services.first)
    elsif ranges.size == 1
      make_sidebar_solo_link(ranges)
    end
  end

  def get_services(type)
    Service.all.collect { |s| s if s.main_type == type }.reject(&:nil?)
  end

  def get_service_ranges(services)
    services.collect do |serv|
      IpRange.where(service_id: serv.id).order('network::inet ASC')
    end
  end

  def make_sidebar_submenu(service_ranges, service)
    link = "#{fa_icon(service.icon)}#{content_tag(:span, service.main_name)}"
    link << fa_icon('chevron-right', class: 'arrow')
    links = link_to(link.html_safe, '#')
    links << content_tag(:ul, make_sidebar_submenu_links(service_ranges).html_safe)

    content_tag(:li, links.html_safe, class: 'submenu')
  end

  def make_sidebar_submenu_links(service_ranges)
    service_ranges.map do |range|
      make_sidebar_submenu_link(range)
    end.join('')
  end

  def make_sidebar_submenu_link(range)
    content_tag(:li, link_to(range.name, iprange_path(range)))
  end

  def make_sidebar_solo_link(ranges)
    range = ranges.first
    content_tag(:li) do
      link_to(iprange_path(range)) do
        fa_icon(range.service.icon) +
          content_tag(:span, range.service.name)
      end
    end
  end
end
