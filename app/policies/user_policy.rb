# frozen_string_literal: true

# User Policy
class UserPolicy < ApplicationPolicy
  def show?
    record == user || record.active?
  end
end
