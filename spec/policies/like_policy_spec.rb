# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikePolicy, type: :policy do
  subject(:policy) { described_class }

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :like }

    permissions :create?, :index? do
      it 'is allowed to create and view list of instances' do
        expect(policy).to permit(user, record)
      end
    end

    permissions :destroy? do
      it "is not allowed delete the instance that doesn't belong to him" do
        expect(policy).not_to permit(user, record)
      end
    end
  end

  context 'when user presents and instance belongs to him' do
    let(:user) { create :user }
    let(:record) { create :like, user: user }

    permissions :destroy? do
      it 'is allowed and delete the instance' do
        expect(policy).to permit(user, record)
      end
    end
  end
end
