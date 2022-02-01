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
GENERATE_CONVERSATIONS_COUNT = 6
GENERATE_DIALOG_COUNT = 6
GENERATE_PROFILE_COUNT = 6
USER_SUBSCRIPTIONS_COUNT = 10

users = FactoryBot.create_list(:user, NUMBER_OF_USERS)

users.each do |user|
  FactoryBot.create_list(:post, GENERATE_POSTS_COUNT, user: user)
  FactoryBot.create_list(:post_with_pictures_and_likes, GENERATE_POSTS_COUNT, user: user)
end

# rubocop:disable Layout/LineLength
conversations = FactoryBot.create_list(:conversation, GENERATE_CONVERSATIONS_COUNT, :with_multiple_users, users: users.sample(rand(3..NUMBER_OF_USERS)))
conversations += FactoryBot.create_list(:conversation, GENERATE_CONVERSATIONS_COUNT, :dialog, users: users)
# rubocop:enable Layout/LineLength

users.each_slice(2) do |subscriber, subscription|
  UserSubscription.create(subscriber: subscriber, subscription: subscription)
end

conversations.each do |conversation|
  users = conversation.users
  users.each do |user|
    chance = rand
    if chance.between?(0, 0.4)
      FactoryBot.create(:message, user: user, conversation: conversation)
    elsif chance.between?(0.5, 0.9)
      FactoryBot.create_list(:message, rand(MIN_LIMIT_OF_MESSAGES..MAX_LIMIT_OF_MESSAGES), user: user, conversation: conversation)
    end
  end
end

FactoryBot.create_list(:profile, GENERATE_PROFILE_COUNT)
FactoryBot.create_list(:tag, GENERATE_TAGS_COUNT)
