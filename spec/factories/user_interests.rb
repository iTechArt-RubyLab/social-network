# frozen_string_literal: true

FactoryBot.define do
  factory :user_interest do
    profile_id { Profile.all.sample.id }
    tag_id { Tag.all.sample.id }
  end
end
