FactoryBot.define do
  factory :profile do
    surname { 'MyString' }
    name { 'MyString' }
    patronymic { 'MyString' }
    birthday { '2022-01-20' }
    email { 'MyString' }
    phone { 'MyString' }
    photo { nil }
    about { 'MyText' }
    hidden { false }
    verified { false }
  end
end
