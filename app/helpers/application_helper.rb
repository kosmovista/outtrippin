module ApplicationHelper
  def errors_for(object, field)
    "<small class='error hide'>#{parse_error_message object.errors.messages[field]}</small>".html_safe
  end

  def set_page_title(title)
    content_for :title do
      title
    end
  end

  def set_page_desc(desc)
    content_for :desc do
      desc
    end
  end

  def set_page_pic(pic)
    content_for :pic do
      pic
    end
  end

  private

  def parse_error_message(messages)
    unless messages.blank?
      messages_string = ""
      messages.each { |m| messages_string << m.capitalize + "<br/>" }
      messages_string
    end
  end
end
