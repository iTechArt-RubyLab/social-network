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
#  user_id          :bigint
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
require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:message) { FactoryBot.build(:message, user: user) }
  let(:empty_message) { FactoryBot.build(:message, :empty, user: user) }
  let(:message_without_user) { FactoryBot.build(:message, :without_user, user: user) }

  context 'with valid attributes' do
    it 'is valid' do
      expect(message).to be_valid
    end
  end

  context 'without message' do
    it 'is invalid' do
      expect(empty_message).not_to be_valid
    end

    it 'is not saved' do
      expect do
        empty_message.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Text can't be blank")
    end
  end

  context 'without user id' do
    it 'is invalid' do
      expect(message_without_user).not_to be_valid
    end

    it 'is not saved' do
      expect do
        message_without_user.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Messageable can't be blank")
    end
  end
end
