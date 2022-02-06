# frozen_string_literal: true

# Serializer for Like
class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user, :likeable
end
