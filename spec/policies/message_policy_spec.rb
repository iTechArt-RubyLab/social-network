require 'rails_helper'

RSpec.describe MessagePolicy, type: :policy do
  subject { described_class }

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :like }

    permissions :index?, :create? do
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
