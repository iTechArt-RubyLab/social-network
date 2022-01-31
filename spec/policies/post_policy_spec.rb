require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { described_class }

  context 'when user is unauthorized' do
    let(:user) { nil }
    let(:record) { create :post }

    permissions :create?, :update?, :destroy? do
      it 'is not allowed to create, update or delete record' do
        expect(subject).not_to permit(user, record)
      end
    end

    permissions :index?, :show? do
      it 'is allowed to see public posts' do
        expect(subject).to permit(user, record)
      end
    end
  end

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :post }
    let(:private_record) { create :post, :private }

    permissions :create? do
      it 'is allowed to create instances' do
        expect(subject).to permit(user, record)
      end
    end

    permissions :show? do
      it 'is allowed to see private records' do
        expect(subject).to permit(user, private_record)
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
