# frozen_string_literal: true

# class responsible for User Serialization
class UserSerializer < ActiveModel::Serializer
  attribute :id
  attribute :last_sign_in_at
  attribute :profile, key: :profile_id do
    object.id
  end

  attribute :subscribers_count
  attribute :subscriptions_count

  def subscribers_count
    object.subscribers.count
  end

  def subscriptions_count
    object.subscriptions.count
  end
end
