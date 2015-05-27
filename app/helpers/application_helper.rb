module ApplicationHelper
  def bootstrap_flash
    content_tag :div, class: "col-sm-12" do
      flash.map do |key, message|
        render "shared/flash", key: alert_mapping[key], message: message
      end.join.html_safe
    end if flash.any?
  end

  def alert_mapping
    @alert_mapping ||= { alert: "warning", notice: "info", error: "danger" }.with_indifferent_access
  end
end
