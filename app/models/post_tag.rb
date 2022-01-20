# == Schema Information
#
# Table name: post_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_post_tags_on_post_id  (post_id)
#  index_post_tags_on_tag_id   (tag_id)
#
class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
end
