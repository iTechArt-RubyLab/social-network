# == Schema Information
#
# Table name: user_subscriptions
#
#  id              :bigint           not null, primary key
#  status          :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  subscriber_id   :bigint           not null
#  subscription_id :bigint           not null
#
# Indexes
#
#  index_user_subscriptions_on_subscriber_id                      (subscriber_id)
#  index_user_subscriptions_on_subscriber_id_and_subscription_id  (subscriber_id,subscription_id) UNIQUE
#  index_user_subscriptions_on_subscription_id                    (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscriber_id => users.id)
#  fk_rails_...  (subscription_id => users.id)
#
require 'rails_helper'

RSpec.describe UserSubscription, type: :model do
  let(:subscriber) { FactoryBot.create(:user) }
  let(:subscription) { FactoryBot.create(:user) }
  let(:user_subscription) { FactoryBot.create(:user_subscription, subscriber: subscriber, subscription: subscription) }

  describe 'subscriber' do
    it 'has user subscriptions' do
      expect(subscriber).to have_many :user_subscriptions
    end

    it 'has user subscribers' do
      expect(subscriber).to have_many :user_subscribers
    end

    it 'has subscriptions' do
      expect(subscriber).to have_many :subscriptions
    end

    it 'has subscribers' do
      expect(subscriber).to have_many :subscribers
    end
  end

  describe 'subscription' do
    it 'has user subscriptions' do
      expect(subscription).to have_many :user_subscriptions
    end

    it 'has user subscribers' do
      expect(subscription).to have_many :user_subscribers
    end

    it 'has subscriptions' do
      expect(subscription).to have_many :subscriptions
    end

    it 'has subscribers' do
      expect(subscription).to have_many :subscribers
    end
  end

  context 'without subscriber' do
    before { user_subscription.update(subscriber_id: nil) }

    it 'is invalid' do
      expect(user_subscription).not_to be_valid
    end

    it 'is not saved' do
      expect do
        user_subscription.save
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Subscriber can\'t be blank')
    end
  end

  context 'without subscription' do
    before { user_subscription.update(subscription_id: nil) }

    it 'is invalid' do
      expect(user_subscription).not_to be_valid
    end

    it 'is not saved' do
      expect do
        user_subscription.save
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Subscription can\'t be blank')
    end
  end

  context 'when has the same subscriber and subscription' do
    before { user_subscription.update(subscription: subscriber) }

    it 'is invalid' do
      expect(user_subscription).not_to be_valid
    end

    it 'is not saved' do
      expect do
        user_subscription.save
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Subscriber and Subscription can\'t be the same user')
    end
  end
end
