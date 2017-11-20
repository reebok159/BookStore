class CheckoutService
  attr_reader :params, :user, :order

  def initialize(params, cookies, user, order)
    @params = params
    @user = user
    @order = order
    @cookies = cookies
  end

  def next_stage(state_layout)
    status = :error

    case state_layout
    when 'address'
      status = processing_address
    when 'delivery'
      status = processing_delivery
    when 'payment'
      status = processing_payment
    when 'confirm'
      status = processing_confirm
    end

    status
  end

  def return_to_confirm?(status)
    return if @cookies[:return_to_confirm].nil?
    return if status == :error
    @order.checkout_state = :confirm
    @order.save
    @cookies.delete(:return_to_confirm)
  end

  def processing_address
    params[:user].delete(:shipping_address_attributes) if(@params[:use_billing] == "on")

    if @user.update(user_params)
      save_addresses_to_order(@params[:use_billing])
      @order.next_state! and return :success
    end

    :error
  end

  def processing_delivery
    @order.next_state! and return :success if @order.update(delivery_params)
    :error
  end

  def processing_payment
    @order.next_state! and return :success if @order.update(payment_params)
    :error
  end

  def processing_confirm
    @order.completed_at = DateTime.now
    @order.total_price = @order.pre_total_price
    @order.status = 1

    if @order.save
      @order.next_state!
      return :success
    end

    :error
  end

  private

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

    @order.build_order_address(data).save
  end

  def user_params
    params.require(:user).permit(
      billing_address_attributes:
            %i[first_name last_name address city zip country phone id],
      shipping_address_attributes:
            %i[first_name last_name address city zip country phone id]
    )
  end

  def delivery_params
    params.require(:order).permit(:delivery_method_id)
  end

  def payment_params
    params.require(:order)
          .permit(credit_card_attributes: %i[number name cvv expires])
  end
end
