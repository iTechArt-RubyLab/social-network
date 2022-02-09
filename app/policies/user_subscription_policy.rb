# frozen_string_literal: true

# UserSubscriptionPolicy
class UserSubscriptionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    create? && (subscriber? || subscription?)
  end

  def subscribers?
    create?
  end

  def subscriptions?
    create?
  end

  private

  def subscriber?
    record.subscriber == user
  end

  def subscription?
    record.subscription == user
  end
end
