module DashboardHelper
  def make_progress_bar_div(range)
    content_tag(:div, class: 'progress progresscustom progress-striped') do
      percentage = range.percentage_used

      make_progress_bar(range, percentage)
    end
  end

  def make_progress_bar(range, percentage)
    content_tag(
      :div,
      nil,
      class: "progress-bar #{set_progress_bar_color(percentage)}",
      role: 'progressbar',
      aria:
      {
        valuenow: range.percentage_used,
        valuemin: '0',
        valuemax: '100'
      },
      style: "width:#{range.percentage_used}%"
    )
  end

  def set_progress_bar_color(percentage)
    if percentage > 90
      'progress-bar-danger'
    elsif percentage > 65
      'progress-bar-warning'
    elsif percentage > 45
      'progress-bar-info'
    else
      'progress-bar-success'
    end
  end
end
