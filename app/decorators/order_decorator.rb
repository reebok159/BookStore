class OrderDecorator < Draper::Decorator
  delegate_all

  def short_card_number
    "** ** ** #{credit_card.number.last(4)}"
  end

  def number
    "#{object.id+10000000}"
  end

  def format_mdate
    return '-' if object.completed_at.nil?
    object.completed_at.strftime("%Y-%m-%d")
  end

  def format_status
    case object.status
    when 'in_progress'
      I18n.t('orders.status.inprogress')
    when 'in_queue'
      I18n.t('orders.status.inqueue')
    when 'in_delivery'
      I18n.t('orders.status.indelivery')
    when 'delivered'
      I18n.t('orders.status.delivered')
    when 'canceled'
      I18n.t('orders.status.canceled')
    else
      object.status
    end
  end
end
