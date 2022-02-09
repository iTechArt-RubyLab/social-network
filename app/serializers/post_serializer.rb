# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  status     :integer          default("public"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# class responsible for serializing profile data
class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :pictures, :status, :created_at, :updated_at, :user_id, :tags
  attribute :likes

  def likes
    object.likes.count
  end
end
