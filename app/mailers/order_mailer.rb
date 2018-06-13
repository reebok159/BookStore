class OrderMailer < ApplicationMailer
  def complete_email
    @order = params[:order]
    @user = params[:user]
    mail(to: @user.email, subject: '[BookStore] Order Information')
  end
end
