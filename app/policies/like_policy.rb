# frozen_string_literal: true

# LikePolicy
class LikePolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    owns_record?
  end
end
