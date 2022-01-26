# == Schema Information
#
# Table name: subscriptions
#
#  id               :bigint           not null, primary key
#  status           :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  signatory_id_id  :bigint           not null
#  subscriber_id_id :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_signatory_id_id   (signatory_id_id)
#  index_subscriptions_on_subscriber_id_id  (subscriber_id_id)
#
FactoryBot.define do
  factory :subscription do
    subscriber_id { nil }
    signatory_id { nil }
  end
end
