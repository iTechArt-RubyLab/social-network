class LikeSerializer < ActiveModel::Serializer
    attributes :id, :user, :likeable
  end