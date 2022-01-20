# frozen_string_literal: true

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

  context 'without net_state' do
    before { user.update(net_state: nil) }

    it 'is invalid' do
      expect(user).not_to be_valid
    end

    it 'is not saved' do
      expect do
        user.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Net state can't be blank")
    end
  end

  context 'without profile id' do
    before { user.update(profile_id: nil) }

    it 'is invalid' do
      expect(user).not_to be_valid
    end

    it 'is not saved' do
      expect do
        user.save!
      end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Profile can't be blank")
    end
  end
end
