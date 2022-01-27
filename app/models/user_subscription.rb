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
class UserSubscription < ApplicationRecord
  belongs_to :subscriber, class_name: 'User', validate: true
  belongs_to :subscription, class_name: 'User', validate: true

  validates :subscriber, uniqueness: { scope: :subscription }

  validate :different_subscriber_and_subscription_validation

  private

  def different_subscriber_and_subscription_validation
    if subscriber == subscription
      errors.add :base, 'Subscriber and Subscription can\'t be the same user'
    end
  end
end
