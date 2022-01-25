# frozen_string_literal: true

# == Schema Information
#
# Table name: post_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_post_tags_on_post_id             (post_id)
#  index_post_tags_on_post_id_and_tag_id  (post_id,tag_id) UNIQUE
#  index_post_tags_on_tag_id              (tag_id)
#
require 'rails_helper'

RSpec.describe PostTag, type: :model do
  let(:tag) { FactoryBot.create(:tag) }
  let(:post) { FactoryBot.create(:post) }
  let(:post_tag) { FactoryBot.create(:post_tag, post: post, tag: tag) }

  context 'with existing assotiations' do
    it 'tag must exist' do
      expect(post.tag).to exist
    end

    it 'post must exist' do
      expect(tag.post).to exist
    end
  end

  context 'with connected associations' do
    it { expect(tag.post).to eq(post) }
    it { expect(post.tag).to eq(tag) }
  end

  context 'without post' do
    before {post_tag.update(post_id: nil)}

    it 'is invalid' do
      is_expected.not_to be_valid
    end

    it 'is not saved' do
      expect { post_tag.save! }.to
      raise_error(ActiveRecord::RecordInvalid, "Validation failed: Profile can't be blank")
    end
  end

  context 'without tag' do
    before { post_tag.update(tag_id: nil) }

    it 'is invalid' do
      is_expected.not_to be_valid
    end

    it 'is not saved' do
      expect { post_tags.save! }.to
      raise_error(ActiveRecord::RecordInvalid, "Validation failed: Profile can't be blank")
    end
  end
end
