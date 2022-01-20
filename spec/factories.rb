require "faker"

FactoryBot.define do
  factory :tag do
    name { Faker::Hobby.unique.activity }
  end
end
