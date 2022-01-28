# frozen_string_literal: true

require 'factory_bot_rails'

USERS_WITH_MULTIPLE_MESSAGES = 2
USERS_WITH_NO_MESSAGES = 3
USERS_WITH_A_SINGLE_MESSAGE = 5
NUMBER_OF_USERS = USERS_WITH_MULTIPLE_MESSAGES + USERS_WITH_NO_MESSAGES + USERS_WITH_A_SINGLE_MESSAGE

MIN_LIMIT_OF_MESSAGES = 3
MAX_LIMIT_OF_MESSAGES = 7

GENERATE_TAGS_COUNT = 30
GENERATE_CONVERSATION_COUNT = 6
GENERATE_PROFILE_COUNT = 6

users = FactoryBot.create_list(:user, NUMBER_OF_USERS)

USERS_WITH_MULTIPLE_MESSAGES.times do
  user = users.delete(users.sample)
  FactoryBot.create_list(:message, rand(MIN_LIMIT_OF_MESSAGES..MAX_LIMIT_OF_MESSAGES), user: user)
end

USERS_WITH_A_SINGLE_MESSAGE.times do
  user = users.delete(users.sample)
  FactoryBot.create(:message, user: user)
end

FactoryBot.create_list(:profile, GENERATE_PROFILE_COUNT)
FactoryBot.create_list(:tag, GENERATE_TAGS_COUNT)
FactoryBot.create_list(:conversation, GENERATE_CONVERSATION_COUNT)
