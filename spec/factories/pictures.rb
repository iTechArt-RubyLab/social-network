FactoryBot.define do
  factory :picture, class: 'Picture' do
    trait :invalid do
      images { Rack::Test::UploadedFile.new("#{::Rails.root}/spec/support/assets/1.jpg") }
    end

    trait :empty do
      images { nil }
    end
  end
end
