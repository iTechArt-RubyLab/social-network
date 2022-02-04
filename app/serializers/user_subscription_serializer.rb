# frozen_string_literal: true

# Class responsible for serializing user subscription data
class UserSubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :subscriber, :subscription
end
