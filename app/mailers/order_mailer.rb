# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def complete_email
    @order = params[:order]
    @user = @order.user
    mail(to: @user.email, subject: I18n.t('mailer.order.subject'))
  end
end
