class Ability
  include CanCan::Ability

  def initialize(customer)
    can :read, :all
    can :manage, OrderItem
    if customer.present?
      can :manage, Order
    # elsif customer.confirmed_at
    #   can :create, Review
    end
  end
end