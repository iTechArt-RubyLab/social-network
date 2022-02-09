# frozen_string_literal: true

# Class responsible for serializing user data
class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id
  attribute :full_name
  attribute :last_sign_in_at
  attribute :subscribe_url
  attribute :subscribers_count
  attribute :subscriptions_count

  def full_name
    profile = object.profile
    "#{profile.surname} #{profile.name} #{profile.patronymic}"
  end

  def subscribe_url
    api_v1_user_subscribe_path(object.id)
  end

  def subscribers_count
    object.subscribers.count
  end

  def subscriptions_count
    object.subscriptions.count
  end
end
