# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  about      :text
#  birthday   :date             not null
#  hidden     :boolean          default(FALSE), not null
#  name       :string           not null
#  patronymic :string
#  phone      :string(15)
#  surname    :string           not null
#  verified   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_phone    (phone) UNIQUE
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject(:profile) { FactoryBot.build(:profile) }

  describe 'validation tests' do
    context 'when we have required fields to fill in' do
      it 'ensures surname presecence' do
        profile.surname = nil
        expect(profile.save).to eq(false)
      end

      it 'ensures name presecence' do
        profile.name = nil
        expect(profile.save).to eq(false)
      end

      it 'ensures birthday presecence' do
        profile.birthday = nil
        expect(profile.save).to eq(false)
      end

      it 'ensures phone presecence' do
        profile.phone = nil
        expect(profile.save).to eq(false)
      end

      it 'ensures about presecence' do
        profile.about = nil
        expect(profile.save).to eq(false)
      end

      it 'saves successfully' do
        expect(profile.save).to eq(true)
      end

      it 'is associated with a user' do
        expect(profile).to belong_to(:user)
      end
    end
  end

  describe 'phone limit test' do
    context 'when phone limit not more than 15 digits' do
      it 'ensures phone limit <= 15' do
        expect(profile.phone.size <= 15).to eq(true)
      end

      it 'return error' do
        profile.phone = '1234567890123456'
        expect(profile.save).to eq(false)
      end
    end
  end
end
