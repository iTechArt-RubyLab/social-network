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
FactoryBot.define do
  factory :user_subscription do
    
  end
end
