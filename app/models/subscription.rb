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
class Subscription < ApplicationRecord
  belongs_to :subscriber, class_name: "User"
  belongs_to :signatory, class_name: "User"
end
