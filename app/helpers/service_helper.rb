module ServiceHelper
  def get_service_ranges(service)
    IpRange.where(service_id: service.id).order('network::inet ASC')
  end

  def make_sidebar_submenu
    #
  end

  def make_sidebar_submenu_link(range)
    content_tag(:li, link_to(range.network_name, iprange_path(range)))
  end

  def make_sidebar_submenu(ranges, service)
    content_tag(:li, class: 'submenu') do
      link_to('#') do
        fa_icon service.icon
        content_tag :span, service.main_name
      end
      content_tag :i, '', class: 'arrow fa fa-chevron-right'
      content_tag(:ul) do
        ranges.each do |range|
          make_sidebar_submenu_link(range)
        end
      end
    end
  end

  def get_sidebar_service_links(type)
    service = Service.find_by(main_type: type)
    ranges = get_service_ranges(serv)
    if ranges.size > 1
      make_sidebar_submenu(ranges, service)
    elsif ranges.size == 1
      range = ranges.first
      content_tag(:li) do
        link_to(iprange_path(range)) do
          fa_icon range.service.icon
          content_tag(:span, range.service.name)
        end
      end
    end
  end
end
