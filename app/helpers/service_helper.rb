module ServiceHelper
  def get_service_ranges(service)
    IpRange.where(service_id: service.id).order('network::inet ASC')
  end

  def make_sidebar_submenu_link(range)
    content_tag(:li, link_to(range.name, iprange_path(range)))
  end

  def make_sidebar_submenu(ranges, service)
    @sidebar_menu = "#{fa_icon service.icon} #{content_tag(:span, service.main_name)}"

    content_tag(:li, class: 'submenu') do
      concat(link_to(@sidebar_menu, '#'))
      concat(content_tag(:i, '', class: 'arrow fa fa-chevron-right'))

      @sidebar_links = ''

      ranges.each do |range|
        @sidebar_links << make_sidebar_submenu_link(range)
      end
      concat(content_tag(:ul, @sidebar_links))
    end
  end

  def get_sidebar_service_links(type)
    service = Service.find_by(main_type: type)
    ranges = get_service_ranges(service)

    if ranges.size > 1
      make_sidebar_submenu(ranges, service)
    elsif ranges.size == 1
      range = ranges.first
      @link = "#{fa_icon range.service.icon} #{content_tag(:span, range.service.name)}"
      content_tag(:li, link_to(@link, iprange_path(range)))
    end
  end
end
