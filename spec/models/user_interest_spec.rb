# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserInterest, type: :model do
  let(:user_interest) { create(:user_interest) }

  it 'profile must exist' do
    Profile.find(expect(user_interest.profile_id)).exist
  end

  it 'tag must exist' do
    Tag.find(expect(user_interest.tag_id)).exist
  end
end
