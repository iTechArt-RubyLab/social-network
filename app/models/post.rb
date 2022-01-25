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
  has_many :pictures, as: :picturable
  has_many :likes, as: :likeable
  has_many :post_tags
  has_many :tags, through: :post_tags

  enum status: %i[public private], _suffix: true

  VALIDATE_MIN_CHARACTERS_BODY = 2
  VALIDATE_MAX_CHARACTERS_BODY = 280

  validates :status, presence: true
  # rubocop:disable Layout/LineLength
  validates :body, presence: true, length: { in: VALIDATE_MIN_CHARACTERS_BODY..VALIDATE_MAX_CHARACTERS_BODY }
  # rubocop:enable Layout/LineLength
end
