require 'rails_helper'

RSpec.describe UserSubscriptionPolicy, type: :policy do
  subject { described_class }

  let(:subscriber) { create :user }
  let(:subscription) { create :user }

  context 'when user presents' do
    let(:user) { create :user }
    let(:record) { create :user_subscription }

    permissions :create?, :index? do
      it 'is allowed to create and view list of instances' do
        expect(subject).to permit(user, record)
      end
    end

    permissions :destroy? do
      let(:record) { create :user_subscription, subscriber: subscriber, subscription: subscription }

      it "is not allowed to delete the instance that doesn't belong to user" do
        expect(subject).not_to permit(user, record)
      end

      it "is allowed to delete the instance that belong to user" do
        expect(subject).to permit(subscriber, record)
        expect(subject).to permit(subscription, record)
      end
    end
  end
end
