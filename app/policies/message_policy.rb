# frozen_string_literal: true

# MessagePolicy
class MessagePolicy < ApplicationPolicy
  def create?
    conversation_member?
  end

  def update?
    owns_record?
  end

  def destroy?
    update?
  end

  private

  def conversation_member?
    record.conversation.users.include?(user)
  end
end
