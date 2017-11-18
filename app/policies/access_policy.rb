class AccessPolicy
  include AccessGranted::Policy

  def configure
    role :admin, proc { |user| user &&user.admin? } do
      can :manage, Restaurant
      can :manage, User
      can :manage, Order
      can :manage, Point
    end

    role :member, proc { |user| user && user.member? } do
      can :create, Order
      can :create, User
      can [:read], Order do |order, user|
        order.restaurant == user.restaurant
      end
    end
  end
end
