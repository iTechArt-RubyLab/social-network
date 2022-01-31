# frozen_string_literal: true

# == Schema Information
#
# Table name: user_conversations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_user_conversations_on_conversation_id              (conversation_id)
#  index_user_conversations_on_user_id                      (user_id)
#  index_user_conversations_on_user_id_and_conversation_id  (user_id,conversation_id) UNIQUE
#
class UserConversation < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :conversation_id, uniqueness: { scope: :user_id }
end
