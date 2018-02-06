class OrderDecorator < Draper::Decorator
  delegate_all

  def short_card_number
    '** ' * 3 << credit_card.number.last(4)
  end

  def number
    object.id + 10000000
  end

  def format_mdate
    return '-' if object.completed_at.nil?
    object.completed_at.strftime("%Y-%m-%d")
  end

  def format_status
    status = object.status
    I18n.t("orders.status.#{status}")
  end
end
