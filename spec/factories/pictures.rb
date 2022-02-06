# frozen_string_literal: true

# == Schema Information
#
# Table name: pictures
#
#  id              :bigint           not null, primary key
#  picturable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  picturable_id   :bigint
#
# Indexes
#
#  index_pictures_on_picturable  (picturable_type,picturable_id)
#
FactoryBot.define do
  factory :picture, class: 'Picture' do
    images { Rack::Test::UploadedFile.new("#{::Rails.root}/spec/support/assets/1.jpg") }

    trait :posts do
      association :picturable, factory: :post
    end

    trait :profiles do
      association :picturable, factory: :profile
    end

    trait :empty do
      images { nil }
    end
  end
end
