class OrderDecorator < Draper::Decorator
  delegate_all

  def short_card_number
    '** ' * 3 << credit_card.number.last(4)
  end

  def number
    object.id + 10_000_000
  end

  def format_mdate
    object.completed_at&.strftime('%Y-%m-%d') || '-'
  end

  def format_status
    I18n.t("orders.status.#{object.status}")
  end

  def items
    object.order_items.decorate
  end
end
