# frozen_string_literal: true

require 'factory_bot_rails'

Tag.delete_all
Profile.delete_all
Message.delete_all
Like.delete_all
User.delete_all
Picture.delete_all
Post.delete_all

USERS_WITH_MULTIPLE_MESSAGES = 2
USERS_WITH_NO_MESSAGES = 3
USERS_WITH_A_SINGLE_MESSAGE = 5
NUMBER_OF_USERS = USERS_WITH_MULTIPLE_MESSAGES + USERS_WITH_NO_MESSAGES + USERS_WITH_A_SINGLE_MESSAGE

MIN_LIMIT_OF_MESSAGES = 3
MAX_LIMIT_OF_MESSAGES = 7

GENERATE_TAGS_COUNT = 30
GENERATE_POSTS_COUNT = 5
GENERATE_SUBSCRIPTIONS_COUNT = 10
GENERATE_CONVERSATIONS_COUNT = 6
GENERATE_PROFILE_COUNT = 6
USER_SUBSCRIPTIONS_COUNT = 10

users = FactoryBot.create_list(:user, NUMBER_OF_USERS)
users.each do |user|
  FactoryBot.create_list(:post, GENERATE_POSTS_COUNT, user: user)
  FactoryBot.create_list(:post_with_pictures_and_likes, GENERATE_POSTS_COUNT, user: user)
end

USER_SUBSCRIPTIONS_COUNT.times do
  user1 = users.sample
  user2 = users.sample
  loop do
    user2 = users.sample
    break if user2 == user1
  end

  UserSubscription.create(subscriber_id: user1, subscription_id: user2)
end

USERS_WITH_MULTIPLE_MESSAGES.times do
  user = users.delete(users.sample)
  FactoryBot.create_list(:message, rand(MIN_LIMIT_OF_MESSAGES..MAX_LIMIT_OF_MESSAGES), user: user)
end

USERS_WITH_A_SINGLE_MESSAGE.times do
  user = users.delete(users.sample)
  FactoryBot.create(:message, user: user)
end

FactoryBot.create_list(:subscription, GENERATE_SUBSCRIPTIONS_COUNT)
FactoryBot.create_list(:profile, GENERATE_PROFILE_COUNT)
FactoryBot.create_list(:tag, GENERATE_TAGS_COUNT)
FactoryBot.create_list(:conversation, GENERATE_CONVERSATIONS_COUNT)
