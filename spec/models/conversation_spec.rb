# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  subject(:conversation) { FactoryBot.build(:conversation) }

  describe 'validation test' do
    context 'when we have required fields to fill in' do
      it 'ensures name presecence' do
        conversation.name = nil
        expect(conversation.save).to eq(false)
      end

      it 'saves successfully' do
        expect(conversation.save).to eq(true)
      end
    end
  end
end
