# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, order = nil)
    user ||= User.new

    if user.is_admin?
      can :create, Review, user_id: user.id
      can :manage, :all
      return
    end

    can :read, Book
    can :read, Review
    return unless order

    can %i[create update destroy], OrderItem, order_id: order.id

    if user.persisted?
      can :create, Review, user_id: user.id
      can :read, Order, status: Order.statuses.keys - ['in_progress'], user_id: user.id
      can :create, Order, user_id: user.id

      can :update, Order, id: order.id, user_id: user.id
      can %i[read create update], ShippingAddress, shipping_a_type: 'User', shipping_a_id: user.id
      can %i[read create update], BillingAddress, billing_a_type: 'User', billing_a_id: user.id
    else
      can %i[create update], Order, id: order.id
    end
  end
end
