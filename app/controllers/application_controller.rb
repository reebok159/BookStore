# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :last_order, :set_locale, :current_ability
  helper_method :last_order

  [CanCan::AccessDenied, ActiveRecord::RecordNotFound].each do |item|
    rescue_from item do |exception|
      redirect_to main_app.root_url, alert: exception.message
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def last_order
    return create_order if current_user.nil?
    current_user.orders.in_progress.first_or_create
  end

  def create_order
    return guest_order if cookies[:order_id] && guest_order.present?
    order = Order.create
    cookies.signed[:order_id] = order.id
    order
  end

  def guest_order
    Order.find_by(id: cookies.signed[:order_id], status: :in_progress)
  end

  def clear_guest_cookies
    cookies.delete(:order_id)
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, last_order)
  end
end
