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

RSpec.shared_examples 'Post' do
  it 'expects post to be valid' do
    expect(post).to be_valid
  end
end

RSpec.describe Post, type: :model do
  subject(:post) { FactoryBot.create :post }

  context 'when everything is valid' do
    include_examples 'Post'

    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:pictures) }
    it { is_expected.to belong_to(:user) }
  end

  context 'when post is private' do
    subject(:post) { FactoryBot.create :post, :private }

    include_examples 'Post'

    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:pictures) }
    it { is_expected.to belong_to(:user) }
  end

  context 'when body is empty' do
    let(:post_with_empty_body) { FactoryBot.build :post, :with_empty_body }

    it 'cannot be created' do
      expect do
        post_with_empty_body.save!
        # rubocop:disable Layout/LineLength
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Body can't be blank, Body is too short (minimum is 2 characters)")
      # rubocop:enable Layout/LineLength
    end
  end

  context 'when status is empty' do
    let(:post_with_empty_status) { FactoryBot.build :post, :with_empty_status }

    it 'cannot be created' do
      expect do
        post_with_empty_status.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Status can't be blank")
    end
  end

  context 'when user is empty' do
    let(:post_with_empty_user) { FactoryBot.build :post, :with_empty_user }

    it 'cannot be created' do
      expect do
        post_with_empty_user.save!
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: User must exist')
    end
  end
end
