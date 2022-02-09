# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_id   :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_likes_on_likeable  (likeable_type,likeable_id)
#  index_likes_on_user_id   (user_id)
#
# Serializer for Like
class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user, :likeable
end
