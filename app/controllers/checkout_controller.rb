class CheckoutController < ApplicationController
  before_action :authenticate_user!, :select_user

  def index

    if @state_layout == 'address'
      @billing_address = @user.billing_address || @user.build_billing_address
      @shipping_address = @user.shipping_address || @user.build_shipping_address
    elsif @state_layout == 'delivery'
      @delivery_methods = DeliveryMethod.all


    end
    #we start checkout or select necessary stage
  end

  def next_stage
    #state = last_order.checkout_state
    if @state_layout == 'address'
      #pry
      params[:user].delete(:shipping_address_attributes) if(params[:use_billing] == "on")
      if @user.update(user_params)
        save_addresses_to_order(params[:use_billing])
        last_order.next_state!

      else
        render "index"
        return
      end
    end
    redirect_to :checkout
  end

  def save_addresses_to_order(use_billing = nil)
    keys = ['first_name', 'last_name', 'address', 'city', 'zip', 'country', 'phone']
    data = {}
    bl_address_data = @user.billing_address

    keys.each do |item|
      data["billing_#{item}".to_sym] = bl_address_data[item]
    end

    if use_billing == "on"
      keys.each do |item|
        data["shipping_#{item}".to_sym] = bl_address_data[item]
      end
    else
      sh_address_data = @user.shipping_address
      keys.each do |item|
        data["shipping_#{item}".to_sym] = sh_address_data[item]
      end
    end

    last_order.build_order_address(data).save

  end

  def select_user
    state = last_order.checkout_state
    @state_layout = state
    @user = current_user
    @order = last_order
  end

  private

    def user_params
      params.require(:user).permit(
        billing_address_attributes: [:first_name, :last_name, :address, :city, :zip, :country, :phone, :id],
        shipping_address_attributes: [:first_name, :last_name, :address, :city, :zip, :country, :phone, :id])
    end
end
