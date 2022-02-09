# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
# Class responsible for serializing tag data
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
