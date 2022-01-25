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
  let(:post) { FactoryBot.create(:tag) }
  let(:post_tag) { FactoryBot.create(:post_tag, post: post, tag: tag)}

  it 'tag must exist' do
    expect(post.tag).to exist
    expect(tag.post).to exist
  end

  it { expect(tag.post).to eq(post)}
  it { expect(post.tag).to eq(tag)}
end
