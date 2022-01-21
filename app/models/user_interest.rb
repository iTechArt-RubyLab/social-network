# == Schema Information
#
# Table name: user_interests
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_user_interests_on_profile_id             (profile_id)
#  index_user_interests_on_profile_id_and_tag_id  (profile_id,tag_id) UNIQUE
#  index_user_interests_on_tag_id                 (tag_id)
#
class UserInterest < ApplicationRecord
  belongs_to :profile
  belongs_to :tag

  validates :profile_id, uniqueness: { scope: :tag_id }
end
