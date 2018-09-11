# frozen_string_literal: true

class CreditCardValidator < ActiveModel::Validator
  def validate(record)
    expire_time = safe_date(record.expires)

    if expire_time.nil?
      record.errors[:expires] << I18n.t('activerecord.credit_card.validation.expires_invalid')
    elsif Time.current > expire_time
      record.errors[:expires] << I18n.t('activerecord.credit_card.validation.expired')
    end
  end

  private

  def safe_date(expires, default = nil)
    splitted = expires&.split('/')
    Time.new("20#{splitted[1]}", splitted[0]).in_time_zone
  rescue StandardError
    default
  end
end
