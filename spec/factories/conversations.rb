# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :conversation do
    name { Faker::Lorem.word }
    users { create :user }

    trait :dialog do
      users { create_list :user, 2 }
    end

    trait :with_multiple_users do
      users { create_list :user, 10 }
    end

    after(:create) do |conversation, _evaluator|
      conversation.users.each do |user|
        build(:user_conversation, user: user, conversation: conversation).save
      end
    end
  end
end
