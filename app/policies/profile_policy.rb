class ProfilePolicy < ApplicationPolicy
  def show?
    user.present? || !record.hidden
  end

  def create?
    user.present?
  end

  def update?
    user.present? && record.user == user
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
