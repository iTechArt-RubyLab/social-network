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
require 'rails_helper'

RSpec.describe UsersConversation, type: :model do
  subject(:conversation) { FactoryBot.build(:conversation) }
  subject(:user) { FactoryBot.build(:user) }
  subject(:users_conversation) { FactoryBot.create(:users_conversation, conversation: conversation, user: user) }
  
  describe 'validation test' do
    context 'with valid associations' do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to belong_to(:conversation) }
    end
  end
end
