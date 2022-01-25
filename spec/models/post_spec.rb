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

RSpec.describe Post, type: :model do
  context 'when everything is valid' do
    let(:post) { FactoryBot.create :post }
    let(:private) { FactoryBot.build :post, :private }

    it 'is expected to be private post' do expect(private).to be_valid end
    it 'is expected to be public post' do expect(post).to be_valid end
    it { expect(post).to have_many(:likes) }
    it { expect(post).to have_many(:pictures) }
    it { expect(post).to belong_to(:user) }
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
