# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conversations_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :conversation do
    name { Faker::Lorem.word }

    trait :empty do
      name { nil }
    end
  end
end
