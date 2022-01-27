# == Schema Information
#
# Table name: subscriptions
#
#  id            :bigint           not null, primary key
#  status        :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  signatory_id  :bigint           not null
#  subscriber_id :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_signatory_id                    (signatory_id)
#  index_subscriptions_on_subscriber_id                   (subscriber_id)
#  index_subscriptions_on_subscriber_id_and_signatory_id  (subscriber_id,signatory_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (signatory_id => users.id)
#  fk_rails_...  (subscriber_id => users.id)
#
require "rails_helper"

RSpec.describe Subscription, type: :model do
  let(:subscriber) { FactoryBot.create(:user) }
  let(:signatory) { FactoryBot.create(:user) }
  let(:subscription) { FactoryBot.create(:subscription, subscriber: subscriber, signatory: signatory) }

  describe "subscriber" do
    it "has subscriber subscriptions" do
      expect(subscriber).to have_many :subscriber_subscriptions
    end

    it "has signatory subscriptions" do
      expect(subscriber).to have_many :signatory_subscriptions
    end
  end

  describe "signatory" do
    it "has subscriber subscriptions" do
      expect(signatory).to have_many :subscriber_subscriptions
    end

    it "has signatory subscriptions" do
      expect(signatory).to have_many :signatory_subscriptions
    end
  end

  context "without subscriber" do
    before { subscription.update(subscriber_id: nil) }

    it "is invalid" do
      expect(subscription).not_to be_valid
    end

    it "is not saved" do
      expect do
        subscription.save
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Profile can\'t be blank')
    end
  end

  context "without signatory" do
    before { subscription.update(signatory_id: nil) }

    it "is invalid" do
      expect(subscription).not_to be_valid
    end

    it "is not saved" do
      expect do
        subscription.save
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Profile can\'t be blank')
    end
  end
end
