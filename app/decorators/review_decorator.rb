# frozen_string_literal: true

class ReviewDecorator < Draper::Decorator
  delegate_all

  def user_letter
    object.user.email.first.capitalize
  end
end
