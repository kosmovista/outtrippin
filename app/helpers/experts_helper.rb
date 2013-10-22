module ExpertsHelper
  def errors_for(field)
    "<small class='error hide'>#{parse_error_message @expert_registration.errors.messages[field]}</small>".html_safe
  end

  private

  def parse_error_message(messages)
    messages_string = ""
    messages.each { |m| messages_string << m.capitalize + "<br/>" }
    messages_string
  end
end
