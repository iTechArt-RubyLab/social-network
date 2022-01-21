require "faker"

FactoryBot.define do
  factory :tag do
    name { Faker::Hobby.unique.activity }
  end

  factory :post_tag do
    tag_id { Tag.all.sample.id }
    post_id { Post.all.sample.id }
  end
end
