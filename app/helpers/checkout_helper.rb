module CheckoutHelper
  def credit_card_format(card)
    "** ** ** #{card.number.last(4)}"
  end
end
