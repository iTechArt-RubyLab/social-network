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
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
