# == Schema Information
#
# Table name: user_interests
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :bigint
#  tag_id     :bigint
#
# Indexes
#
#  index_user_interests_on_profile_id             (profile_id)
#  index_user_interests_on_profile_id_and_tag_id  (profile_id,tag_id) UNIQUE
#  index_user_interests_on_tag_id                 (tag_id)
#
require "rails_helper"

RSpec.describe UserInterest, type: :model do
  subject { create(:user_interest) }

  before { subject.save }

  it "profile must exist" do
    Profile.find(expect(subject.profile_id)).exist
  end

  it "tag must exist" do
    Tag.find(expect(subject.tag_id)).exist
  end
end
