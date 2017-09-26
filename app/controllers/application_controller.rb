class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :last_order, :set_locale
  before_action :current_ability
  helper_method :last_order

  def index
    render 'layouts/application'
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_cart
    @cart = last_order
  end

  def last_order
    if current_user.nil?
      create_order
      Order.find_by(id: cookies.signed[:order_id], status: :in_progress)
    else
      order = current_user.orders.find_by(status: :in_progress)
      if order.nil?
        current_user.orders.create
      else
        order
      end
    end
  end


  def create_order
    return unless current_user.nil?

    if cookies[:order_id]
      order = Order.find_by(id: cookies.signed[:order_id], status: :in_progress)
      return order if order
    end
    order = Order.create
    cookies.signed[:order_id] = order.id
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

end
