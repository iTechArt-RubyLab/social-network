# frozen_string_literal: true

# == Schema Information
#
# Table name: users_conversations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_users_conversations_on_conversation_id  (conversation_id)
#  index_users_conversations_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#
class UsersConversation < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
end
