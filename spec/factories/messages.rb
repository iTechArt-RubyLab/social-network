# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id               :bigint           not null, primary key
#  messageable_type :string           not null
#  text             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  messageable_id   :bigint           not null
#  user_id          :bigint
#
# Indexes
#
#  index_messages_on_messageable  (messageable_type,messageable_id)
#  index_messages_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :message do
    association :user
    text { Faker::Lorem.paragraph }
    messageable_id { user_id }
    messageable_type { 'user' }

    trait :without_user do
      user_id { nil }
    end

    trait :empty do
      text { nil }
    end
  end
end
