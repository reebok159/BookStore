module OrdersHelper
  def order_filters
    Order.statuses.select { |_, val| val.positive? }
  end

  def active_order_filter
    filter = params[:status].to_i
    selected = Order.statuses.keys[filter]
    return I18n.t('orders.filter.all') if filter.zero? || selected.nil?
    I18n.t("orders.status.#{selected}")
  end
end
