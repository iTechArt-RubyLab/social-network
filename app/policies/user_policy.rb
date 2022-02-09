# frozen_string_literal: true

# User Policy
class UserPolicy < ApplicationPolicy
  def show?
    record == user || record.active
  end

  def subscribers?
    record.active
  end

  def subscriptions?
    record.active
  end

  def subscribe?
    show?
  end

  def unsubscribe?
    show?
  end
end
