# frozen_string_literal: true

# class responsible for serializing profile data
class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :status, :created_at, :updated_at, :user_id, :tags
  attribute :likes

  def likes
    object.likes.count
  end
end
