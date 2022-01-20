# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    status { 'active' }
    net_state { Time.now }
    profile_id { rand(1000) }
  end
end
