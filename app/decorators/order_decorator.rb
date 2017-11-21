class OrderDecorator < Draper::Decorator
  delegate_all

  def short_card_number
    "** ** ** #{credit_card.number.last(4)}"
  end

  def number
    "#{object.id+10000000}"
  end

end
