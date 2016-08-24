module SidebarHelper
  def get_service_ranges(service)
    IpRange.where(service_id: service.id).order('network::inet ASC')
  end

  def get_sidebar_service_links(type)
    serv = Service.find_by(main_type: type)
    ranges = get_service_ranges(serv)
    if ranges.size > 1
      content_tag(:li, class: 'submenu') do
        link_to('#') do
          fa_icon serv.icon
          content_tag :span, serv.main_name
        end
        content_tag :i, '', class: 'arrow fa fa-chevron-right'
        content_tag(:ul) do
          ranges.each do |range|
            content_tag(:li, link_to(range.network_name, iprange_path(range)))
          end
        end
      end
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
