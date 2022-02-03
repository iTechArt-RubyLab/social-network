require 'rails_helper'

RSpec.describe TagPolicy, type: :policy do
  subject { described_class }

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :tag }

    permissions :create?, :index? do
      it 'is allowed to create and view list of instances' do
        expect(subject).to permit(user, record)
      end
    end
  end
end
