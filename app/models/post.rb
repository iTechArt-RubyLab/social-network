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
  belongs_to :user, optional: true
  has_one :picture, as: :picturable
  has_many :likes
  has_many :post_tags
  has_many :tags, through: :post_tags

  enum status: %i[public private], _suffix: true

  MIN_CHARACTERS = 2
  MAX_CHARACTERS = 1000

  validates :body, length: { in: MIN_CHARACTERS..MAX_CHARACTERS }
end
