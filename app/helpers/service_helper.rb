# Global Service Helper for the Sidebar and Other Partials
module ServiceHelper
  def get_service_ranges(service)
    IpRange.where(service_id: service.id).order('network::inet ASC')
  end

  def get_sidebar_service_links(type)
    service = Service.find_by(main_type: type)
    ranges = get_service_ranges(service)
    if ranges.size > 1
      make_sidebar_submenu(ranges, service)
    elsif ranges.size == 1
      make_sidebar_solo_link(ranges)
    end
  end

  def make_sidebar_submenu(service_ranges, service)
    link = "#{fa_icon(service.icon)}#{content_tag(:span, service.main_name)}"
    links = link_to(link.html_safe, '#')

    links << content_tag(:i, '', class: 'arrow fa fa-chevron-right')
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
