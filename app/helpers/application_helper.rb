module ApplicationHelper
  def make_breadcrumb_link(icon, path, link_text, css_class = nil, title = nil)
    link_to(path, class: css_class, title: title) do
      "#{fa_icon(icon)} #{link_text}".html_safe
    end
  end

  def get_alert_type(type)
    case type.to_sym
    when :alert, :danger, :error, :validation_errors
      alert_type = 'alert-danger'
    when :warning, :todo
      alert_type = 'alert-warning'
    when :notice, :success
      alert_type = 'alert-success'
    else
      alert_type = 'alert-info'
    end
  end
end
