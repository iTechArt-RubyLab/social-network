# == Schema Information
#
# Table name: messages
#
#  id               :bigint           not null, primary key
#  messageable_type :string           not null
#  text             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  messageable_id   :integer          not null
#  user_id          :integer          not null
#
FactoryBot.define do
  factory :message do
    user_id { User.all[rand(0..(User.all.each.count - 1))].id }
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
