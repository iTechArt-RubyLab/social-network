# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  text            :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :user, validate: true
  belongs_to :conversation, validate: true
  validates :text, presence: true
end
