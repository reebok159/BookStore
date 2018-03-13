class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Book
    can :manage, OrderItem, order: { user_id: user.id }
    can %i[create update cart], Order, user: user.id

    return unless user.persisted?
    can :read, Order, user_id: user.id
    can :create, Review

    can :manage, :all if user.is_admin?
  end
end
