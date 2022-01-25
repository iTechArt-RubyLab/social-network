# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe UserInterest, type: :model do
  let(:profile) { FactoryBot.create(:profile) }
  let(:tag) { FactoryBot.create(:tag) }
  let(:user_interest) { FactoryBot.create(:user_interest, profile: profile, tag: tag) }

  context 'with existing assotiations' do
    it 'profile must exist' do
      expect(profile.tag).to exist
    end

    it 'tag must exist' do
      expect(tag.profile).to exist
    end
  end

  context 'with connected assotiations' do
    it { expect(tag.profile).to eq(profile) }
    it { expect(profile.tag).to eq(tag) }
  end

  context 'without profile' do
    before { user_interest.update(profile_id: nil) }

    it 'is invalid' do
      is_expected.not_to be_valid
    end

    it 'is not saved' do
      expect { user_interest.save! }.to
      raise_error(ActiveRecord::RecordInvalid, "Validation failed: Profile can't be blank")
    end
  end

  context 'without tag' do
    before { user_interest.update(tag_id: nil) }

    it 'is invalid' do
      is_expected.not_to be_valid
    end

    it 'is not saved' do
      expect { user_interest.save! }.to
      raise_error(ActiveRecord::RecordInvalid, "Validation failed: Profile can't be blank")
    end
  end
end
