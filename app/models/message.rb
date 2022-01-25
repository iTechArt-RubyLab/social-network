# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id               :bigint           not null, primary key
#  messageable_type :string           not null
#  text             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  messageable_id   :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_messages_on_messageable  (messageable_type,messageable_id)
#  index_messages_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  validates :user_id, presence: true
  validates :text, presence: true
  validates :messageable_id, presence: true
  validates :messageable_type, presence: true
  belongs_to :messageable, polymorphic: true
  belongs_to :user
end
