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
class Post < ApplicationRecord
  belongs_to :user
  has_one :picture, as: :picturable
  has_many :likes, as: :likeable
  has_many :post_tags
  has_many :tags, through: :post_tags

  enum status: %i[public private], _suffix: true

  MIN_CHARACTERS = 2
  MAX_CHARACTERS = 280

  validates :status ,presence: true
  validates :body,presence: true, length: { in: MIN_CHARACTERS..MAX_CHARACTERS }
end
