module DashboardHelper
  def get_sidebar_service_links(name)
    service = Service.find_by(main_type: name)
    ranges = IpRange.where(service_id: service.id)

    if ranges.size > 1
      # '<li class="submenu">'.html_safe
      # '<a href=""><i class="fa fa-desktop"></i> <span>DSL</span> <i class="arrow fa fa-chevron-right"></i></a>'.html_safe
      # '<ul>'.html_safe

      ranges.each do |range|
        content_for(':li', link_to(range.network, ip_range_path(range)))
      end

      # '</ul>'.html_safe
      # '</li>'.html_safe
    else
      range = ranges.first
      link_to range do
        fa_icon 'ban'
        content_tag(:span, range.network_name)
      end
    end
  end
end
