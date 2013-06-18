# encoding: utf-8
module ApplicationHelper

  # Overwrite base devise method
  def error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
      <div id="error_explanation">
      <ul>#{messages}</ul>
      </div>
    HTML

    html.html_safe
  end

  def flash_message type, message
      content_tag :div, class: type do
        (content_tag :button, "×", class: :close, data: { dismiss: "alert" }) + 
        message.html_safe
      end
  end

end
