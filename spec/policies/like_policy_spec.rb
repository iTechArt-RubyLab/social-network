require 'rails_helper'

RSpec.describe LikePolicy, type: :policy do
  subject { described_class }

  context 'when user is unauthorized' do
    let(:user) { nil }
    let(:record) { create :like }

    permissions :show?, :create?, :update?, :destroy? do
      it 'is not allowed to do a thing' do
        expect(subject).not_to permit(user, record)
      end
    end

    permissions :index? do
      it 'is allowed only to have a look' do
        expect(subject).to permit(user, record)
      end
    end
  end

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :like }

    permissions :create?, :index? do
      it 'is allowed to create and view list of instances' do
        expect(subject).to permit(user, record)
      end
    end

    permissions :update?, :edit?, :destroy? do
      it "is not allowed to update and delete the instance that doesn't belong to him" do
        expect(subject).not_to permit(user, record)
      end
    end
  end

  context 'when user presents and instance belongs to him' do
    let(:user) { create :user }
    let(:record) { create :like, user: user }

    permissions :update?, :edit?, :destroy? do
      it "is allowed to update and delete the instance" do
        expect(subject).to permit(user, record)
      end
    end
  end
end
