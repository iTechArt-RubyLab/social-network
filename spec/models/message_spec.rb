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
require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { create :user }

  shared_examples 'valid message' do
    subject { build(:message, user: user) }

    it { is_expected.to be_valid }
  end

  shared_examples 'invalid message' do
    it { is_expected.not_to be_valid }
  end

  describe '#user_id' do
    subject { build(:message, user: nil) }

    context 'when presents' do
      it_behaves_like 'valid message'
    end

    context "when doesn't present" do
      it_behaves_like 'invalid message'
    end
  end

  describe '#text' do
    subject { build(:message, :empty, user: user) }

    context 'when presents' do
      it_behaves_like 'valid message'
    end

    context "when doesn't present" do
      it_behaves_like 'invalid message'
    end
  end

  describe '#messageable' do
    subject { build(:message, :empty, user: user, messageable: nil) }

    context 'when presents' do
      it_behaves_like 'valid message'
    end

    context "when doesn't present" do
      it_behaves_like 'invalid message'
    end
  end

  describe "#timestamps" do
    subject { build(:message, :empty, user: user, record_timestamps: nil) }

    context 'when presents' do
      it_behaves_like 'valid message'
    end

    context "when doesn't present" do
      it_behaves_like 'invalid message'
    end
  end
end
