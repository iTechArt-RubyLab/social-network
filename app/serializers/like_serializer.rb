# frozen_string_literal: true

class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user, :likeable
end
