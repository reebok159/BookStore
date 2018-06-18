class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Book
    can :read, Review
    can %i[create update cart], Order, user_id: user.id
    can %i[create update destroy], OrderItem, order: { user_id: user.id }

    return unless user.persisted?
    can :read, Order, user_id: user.id
    can :create, Review
    can %i[read create update], ShippingAddress, shipping_a_type: 'User', shipping_a_id: user.id
    can %i[create update], BillingAddress, billing_a_type: 'User', billing_a_id: user.id

    can :manage, :all if user.is_admin?
  end
end
