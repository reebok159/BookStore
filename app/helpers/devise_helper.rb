# frozen_string_literal: true

module DeviseHelper
  def devise_error_messages!
    error_key = 'errors.messages.not_saved'
    unless flash.empty?
      flash_alerts = flash.map { |msg| msg[1] }
      error_key = 'devise.failure.invalid'
    end
    return '' if resource.errors.empty? && flash_alerts.nil?
    errs = resource.errors.empty? ? flash_alerts : resource.errors.full_messages
    messages = errs.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t(error_key, count: errs.count, authentication_keys: resource.class.model_name.human.downcase)
    html_with_errors(sentence, messages).html_safe
  end

  private

  def html_with_errors(sentence, messages)
    <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML
  end
end
