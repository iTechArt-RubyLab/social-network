# frozen_string_literal: true

# Profily policy
class ConversationPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def add_user?
    true
  end

  def delete_user?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  # Profile policy scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
