class ReviewDecorator < Draper::Decorator
  delegate_all

  def user_letter
    object.user.email.first.capitalize
  end

  def verified?
    OrderItem.where(
      order_id: object.user.orders.delivered.ids,
      item_id: object.book.id
    ).exists?
  end
end
