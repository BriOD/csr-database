module DashboardHelper
  def make_progress_bar(range)
    # <div class="progress progresscustom progress-striped">
    #   <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="<%= range.percentage_used %>" aria-valuemin="0" aria-valuemax="100" style="width:<%= range.percentage_used %>%"></div>
    # </div><!-- end progress bar -->
    content_tag(:div, class: 'progress progresscustom progress-striped') do
      percentage = range.percentage_used

      if percentage > 90
        content_tag(
          :div,
          nil,
          class: 'progress-bar progress-bar-danger',
          role: 'progressbar',
          aria:
          {
            valuenow: range.percentage_used,
            valuemin: '0',
            valuemax: '100'
          },
          style: "width:#{range.percentage_used}%"
        )
      elsif percentage > 65
        content_tag(
          :div,
          nil,
          class: 'progress-bar progress-bar-warning',
          role: 'progressbar',
          aria:
          {
            valuenow: range.percentage_used,
            valuemin: '0',
            valuemax: '100'
          },
          style: "width:#{range.percentage_used}%"
        )
      elsif percentage > 45
        content_tag(
          :div,
          nil,
          class: 'progress-bar progress-bar-info',
          role: 'progressbar',
          aria:
          {
            valuenow: range.percentage_used,
            valuemin: '0',
            valuemax: '100'
          },
          style: "width:#{range.percentage_used}%"
        )
      else
        content_tag(
          :div,
          nil,
          class: 'progress-bar progress-bar-success',
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
    end
  end
end
