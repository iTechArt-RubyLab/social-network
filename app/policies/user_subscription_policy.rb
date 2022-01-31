class UserSubscriptionPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    create? && [record.subscriber_id, record.subscription_id].include?(user.id)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
