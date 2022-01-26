# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  status     :integer          default("public"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
FactoryBot.define do
  factory :post, class: 'Post' do
    association :user
    body { Faker::Lorem.characters(number: 10, min_alpha: 10) }
    status { 'public' }

    factory :with_likes do
      after(:create) do |post|
        create_list(:like, 5, likeable: post)
      end
    end

    factory :with_pictures do
      after(:create) do |post|
        create_list(:picture, 2, picturable: post)
      end
    end

    trait :private do
      status { 'private' }
    end

    trait :with_empty_body do
      body { nil }
    end

    trait :with_empty_status do
      status { nil }
    end

    trait :with_empty_user do
      user { nil }
    end
  end
end
