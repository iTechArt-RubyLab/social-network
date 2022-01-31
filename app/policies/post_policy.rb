class PostPolicy < ApplicationPolicy
  def show?
    user.present? || record.status == 'public'
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
