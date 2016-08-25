module ApplicationHelper
  def make_breadcrumb_link(icon, path, link_text, css_class = nil, title = nil)
    link_to(path, class: css_class, title: title) do
      "#{fa_icon(icon)} #{link_text}".html_safe
    end
  end
end
