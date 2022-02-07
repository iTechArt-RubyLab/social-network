# frozen_string_literal: true

# Profily policy
class ProfilePolicy < ApplicationPolicy
  def show?
    (record.public? && record.user.active?) || owns_record?
  end

  def create?
    true
  end

  def search?
    true
  end

  def update?
    owns_record?
  end

  # Profile policy scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
