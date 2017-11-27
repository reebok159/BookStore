class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :last_order, unless: :current_user
  before_action :set_locale, :current_ability
  helper_method :last_order

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def last_order
    return create_order if current_user.nil?
    current_user.orders.where(status: :in_progress).first_or_create
  end

  def create_order
    return unless current_user.nil?
    if cookies[:order_id]
      order = Order.find_by(id: cookies.signed[:order_id], status: :in_progress)
      return order if order
    end
    order = Order.create
    cookies.signed[:order_id] = order.id

    order
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
