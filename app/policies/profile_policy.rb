# frozen_string_literal: true

# ProfilePolicy
class ProfilePolicy < ApplicationPolicy
  def show?
    record.public? || owns_record?
  end

  def create?
    true
  end

  def update?
    owns_record?
  end

  # ProfilePolicy Scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
