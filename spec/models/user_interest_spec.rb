require 'rails_helper'

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
