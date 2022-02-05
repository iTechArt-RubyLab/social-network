# frozen_string_literal: true

# Сlass responsible for serializing tag data
class TagSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :profiles_count
  attribute :posts_count

  def profiles_count
    object.profiles.count
  end

  def posts_count
    object.posts.count
  end
end
