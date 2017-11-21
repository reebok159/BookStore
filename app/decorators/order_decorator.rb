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
      'In Progress'
    when 'in_queue'
      'In Queue'
    when 'in_delivery'
      'In Delivery'
    when 'delivered'
      'Delivered'
    when 'canceled'
      'Canceled'
    else
      object.status
    end
  end
end
