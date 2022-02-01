# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  about      :text
#  birthday   :date             not null
#  hidden     :boolean          default(FALSE), not null
#  name       :string           not null
#  patronymic :string
#  phone      :string(15)
#  surname    :string           not null
#  verified   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_phone    (phone) UNIQUE
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :profile do
    association :user
    surname { Faker::Name.last_name }
    name { Faker::Name.first_name }
    patronymic { Faker::Name.middle_name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { Faker::PhoneNumber.unique.cell_phone }
    about { "#{Faker::Address.full_address}, #{Faker::University.name}, #{Faker::Hobby.activity}" }
    hidden { false }
    verified { false }

    trait(:hidden_true) { hidden { true } }
    trait(:verified_true) { verified { true } }
  end
end
