class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :last_order, :set_locale
  before_action :current_ability


  def index
    render 'layouts/application'
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  #for cart
  def last_order
    #pry
    if current_user.nil?
      create_order
      #get order from db by cookie order id
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
    if current_user.nil? && !cookies[:order_id]
      order = Order.create
      cookies.signed[:order_id] = order.id
    end
  end

  private

    def current_ability
      @current_ability ||= Ability.new(current_user)
      #pry
    end

end
