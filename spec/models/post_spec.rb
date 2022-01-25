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
  context 'with valid attributes' do
    let(:post) { FactoryBot.create :post }
    let(:private_post) { FactoryBot.build :post, :private_post }

    it { expect(private_post).to be_valid }
    it { expect(post).to be_valid }
  end

  context 'with invalid attributes' do
    let(:post) { FactoryBot.build :post, :invalid_body }

    it { expect(post).not_to be_valid }
  end

  context 'with user associations' do
    let(:post) { FactoryBot.create :post }

    it { is_expected.to belong_to(:user) }
  end

  context 'with picture associations' do
    let(:post) { FactoryBot.create :post }

    it { is_expected.to have_one(:picture) }
  end

  context 'with like associations' do
    let(:post) { FactoryBot.create :post }

    it { is_expected.to have_many(:likes) }
  end

  context 'with empty attributes' do
    let(:body) { FactoryBot.build :post, :empty_body }
    let(:status) { FactoryBot.build :post, :empty_status }
    let(:user) { FactoryBot.build :post, :empty_user }

    it 'empty body' do
      expect do
        body.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Body can't be blank, " \
        "Body is too short (minimum is 2 characters)")
    end
    it 'empty user association' do
      expect do
        user.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User must exist")
    end
    it 'empty status' do
      expect do
        status.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Status can't be blank")
    end
  end
end
