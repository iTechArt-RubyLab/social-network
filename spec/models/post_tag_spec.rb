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
require "rails_helper"

RSpec.describe PostTag, type: :model do
  subject { create(:post_tag) }

  before { subject.save }

  it "tag must exist" do
    Tag.find(expect(subject.tag_id)).exist
  end

  it "post must exist" do
    Post.find(expect(subject.post_id)).exist
  end
end
