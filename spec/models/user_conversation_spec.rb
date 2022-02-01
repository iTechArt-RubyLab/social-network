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
require 'rails_helper'

RSpec.describe UserConversation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:conversation) { FactoryBot.create(:conversation) }
  let(:user_conversation) { FactoryBot.create(:user_conversation, user: user, conversation: conversation) }

  describe '#user' do
    context 'with existing user' do
      it 'must exist' do
        expect(conversation.user).to exist
      end
    end

    context 'with connected user' do
      it 'must be with correct value' do
        expect(conversation.user).to eq(user)
      end
    end
  end

  describe '#conversation' do
    context 'with existing conversation' do
      it 'must exist' do
        expect(user.conversation).to exist
      end
    end

    context 'with connected conversation' do
      it 'must be with correct value' do
        expect(user.conversation).to eq(conversation)
      end
    end
  end

  context 'without user' do
    before { user_conversation.update(user_id: nil) }

    it 'is invalid' do
      expect(user_conversation).not_to be_valid
    end

    it 'is not saved' do
      expect { user_conversation.save! }.to
      raise_error(ActiveRecord::RecordInvalid, 'Validation failed: User must exist')
    end
  end

  context 'without conversation' do
    before { user_conversation.update(conversation_id: nil) }

    it 'is invalid' do
      expect(user_conversation).not_to be_valid
    end

    it 'is not saved' do
      expect { user_conversation.save! }.to
      raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Conversation must exist')
    end
  end
end
