# frozen_string_literal: true

# TagPolicy
class TagPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    create?
  end

  def posts?
    show?
  end
end
