# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject(:policy) { described_class }

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :profile }
    let(:private_record) { create :profile, :hidden_true }

    permissions :create?, :show? do
      it 'is allowed to create instances and view public records' do
        expect(policy).to permit(user, record)
      end
    end

    permissions :show? do
      it 'is not allowed to see private records' do
        expect(policy).not_to permit(user, private_record)
      end
    end

    permissions :update?, :edit?, :destroy?, :add_tag?, :remove_tag? do
      it "is not allowed to update and delete the instance and that tags that doesn't belong to him" do
        expect(policy).not_to permit(user, record)
      end
    end
  end

  context 'when user presents and instance belongs to him' do
    let(:user) { create :user }
    let(:record) { user.profile }

    permissions :update?, :edit?, :add_tag?, :remove_tag? do
      it 'is allowed to update the instance' do
        expect(policy).to permit(user, record)
      end
    end
  end
end
