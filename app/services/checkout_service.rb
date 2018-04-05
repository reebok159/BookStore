class CheckoutService
  attr_reader :params, :user, :order

  def initialize(params, cookies, user, order)
    @params = params
    @user = user
    @order = order
    @cookies = cookies
  end

  def next_stage(state_layout)
    case state_layout
    when 'address' then processing_address
    when 'delivery' then processing_delivery
    when 'payment' then processing_payment
    when 'confirm' then processing_confirm
    end
  end

  def return_to_confirm(status)
    return if @cookies[:return_to_confirm].blank? || status != :success
    @order.checkout_state = :confirm
    @order.save
    @cookies.delete(:return_to_confirm)
  end

  def processing_address
    addresses = prepare_addresses
    @order.next_state! && (return :success) if @order.update(addresses)
  end

  def processing_delivery
    @order.next_state! && (return :success) if @order.update(delivery_params)
  end

  def processing_payment
    @order.next_state! && (return :success) if @order.update(payment_params)
  end

  def processing_confirm
    @order.completed_at = Time.now
    @order.total_price = @order.pre_total_price
    @order.status = :in_queue
    @order.next_state! && (return :success) if @order.save
  end

  def items
    @order.order_items.decorate
  end

  private

  def prepare_addresses
    addresses = order_params
    if params.key? :use_billing
      addresses[:shipping_address_attributes] = addresses[:billing_address_attributes]
      addresses[:use_billing] = true
    else
      addresses[:use_billing] = nil
    end
    addresses
  end

  def order_params
    params.require(:order).permit(
      billing_address_attributes:
            %i[first_name last_name address city zip country phone],
      shipping_address_attributes:
            %i[first_name last_name address city zip country phone]
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
