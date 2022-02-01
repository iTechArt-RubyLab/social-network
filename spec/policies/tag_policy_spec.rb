require 'rails_helper'

RSpec.describe TagPolicy, type: :policy do
  subject { described_class }

  context 'when user is unauthorized' do
    let(:user) { nil }
    let(:record) { create :tag }

    permissions :show?, :create?, :update?, :destroy? do
      it 'is not allowed to do a thing' do
        expect(subject).not_to permit(user, record)
      end
    end
  end

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :tag }

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
end
