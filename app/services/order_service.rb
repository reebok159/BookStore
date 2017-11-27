class OrderService
  attr_reader :params, :user, :order

  def initialize(order)
    @order = order
  end

  def activate_coupon(coupon)
    coupon = Coupon.find_by(code: coupon)

    if coupon.nil?
      I18n.t('coupon.noexist')
    elsif @order.order_items.blank?
      I18n.t('coupon.cantactivate')
    elsif @order.subtotal < coupon.min_sum_to_activate
      I18n.t('coupon.sumerror')
    elsif DateTime.now > coupon.expires
      I18n.t('coupon.termerror')
    else
      @order.coupon = coupon
      @order.save
      I18n.t('coupon.activatesuccess')
    end
  end
end
