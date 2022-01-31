require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject { described_class }

  context 'when user is unauthorized' do
    let(:user) { nil }
    let(:record) { create :profile }
    let(:hidden_record) { create :profile, :hidden_true }

    permissions :create?, :update?, :destroy? do
      it 'is not allowed to create, update or delete record' do
        expect(subject).not_to permit(user, record)
      end
    end

    permissions :show? do
      it 'is allowed to see public profiles' do
        expect(subject).to permit(user, record)
      end

      it 'is not allowed to see hidden profiles' do
        expect(subject).not_to permit(user, hidden_record)
      end
    end
  end

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :profile }
    let(:hidden_record) { create :profile, :hidden_true }

    permissions :create? do
      it 'is allowed to create instances' do
        expect(subject).to permit(user, record)
      end
    end

    permissions :show? do
      it 'is allowed to see hidden records' do
        expect(subject).to permit(user, hidden_record)
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
    let(:record) { user.profile }

    permissions :update?, :edit?, :destroy? do
      it "is allowed to update and delete the instance" do
        expect(subject).to permit(user, record)
      end
    end
  end
end
