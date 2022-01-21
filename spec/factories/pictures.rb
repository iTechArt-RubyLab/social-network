FactoryBot.define do
  factory :picture, class: Picture do
    trait :invalid do
      picture { Rack::Test::UploadedFile.new("#{::Rails.root}/1.jpg") }
    end

    trait :empty do
      picture { nil }
    end
  end
end
