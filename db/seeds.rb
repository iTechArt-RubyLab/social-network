# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "factory_bot_rails"

GENERATE_TAGS_COUNT = 30

ActiveRecord::Base.transaction do
  GENERATE_TAGS_COUNT.times do |_counter|
    FactoryBot.create(:tag)
  end
end
