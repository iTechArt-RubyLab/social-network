FactoryBot.define do
  factory :profile do
    surname { Faker::Name.last_name }
    name { Faker::Name.first_name }
    patronymic { Faker::Name.middle_name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.unique.cell_phone_in_e164 }
    #photo { nil }
    about { "#{Faker::Address.full_address}, #{Faker::University.name}, #{Faker::Hobby.activity}"  }
    hidden { false }
    verified { false }
  end
end
