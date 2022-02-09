# frozen_string_literal: true

# PostPolicy
class PostPolicy < ApplicationPolicy
  def show?
    record.public_status? || owns_record?
  end

  def create?
    true
  end

  def update?
    owns_record?
  end

  def destroy?
    update?
  end

  def add_tag?
    update?
  end

  def remove_tag?
    update?
  end

  # PostPolicy Scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
