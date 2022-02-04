# frozen_string_literal: true

# MessagePolicy
class MessagePolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    owns_record?
  end

  def destroy?
    update?
  end
end
