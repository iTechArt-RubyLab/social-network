# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  status     :integer          default("public"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
require 'rails_helper'

shared_examples 'valid post' do
  it { is_expected.to be_valid }
  it { is_expected.to have_many(:likes) }
  it { is_expected.to have_many(:pictures) }
  it { is_expected.to belong_to(:user) }
end

RSpec.describe Post, type: :model do
  subject(:post) { create :post }

  context 'when post is public' do
    context 'when everything is valid' do
      include_examples 'valid post'
    end
  end

  context 'when post is private' do
    context 'when everything is valid' do
      subject(:post) { create :post, :private }

      include_examples 'valid post'
    end
  end

  describe '#body' do
    context 'when body is empty' do
      let(:post_with_empty_body) { build :post, :with_empty_body }

      it 'cannot be created' do
        expect do
          post_with_empty_body.save!
          # rubocop:disable Layout/LineLength
        end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Body can't be blank, Body is too short (minimum is 2 characters)")
        # rubocop:enable Layout/LineLength
      end
    end
  end

  describe '#status' do
    context 'when status is empty' do
      let(:post_with_empty_status) { build :post, :with_empty_status }

      it 'cannot be created' do
        expect do
          post_with_empty_status.save!
        end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Status can't be blank")
      end
    end
  end
end
