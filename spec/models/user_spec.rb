# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  status                 :integer          default("active"), not null
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  context 'with valid attributes' do
    it 'is valid' do
      expect(user).to be_valid
    end
  end

  context 'without status' do
    before { user.update(status: nil) }

    it 'is invalid' do
      expect(user).not_to be_valid
    end

    it 'is not saved' do
      expect do
        user.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Status can't be blank, Status is not included in the list")
    end
  end

  context 'with invalid status' do
    it do
      expect do
        user.update(status: 'not_listed')
      end.to raise_error(ArgumentError, "'not_listed' is not a valid status")
    end
  end

end
