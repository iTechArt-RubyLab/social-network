# frozen_string_literal: true

# Profily policy
class ConversationPolicy < ApplicationPolicy
  def show?
    record.users.include?(user)
  end

  def create?
    true
  end

  def add_user?
    show?
  end

  def delete_user?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  # Profile policy scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
