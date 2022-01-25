# frozen_string_literal: true

GENERATE_TAGS_COUNT = 30

FactoryBot.create_list(:user, 6)
FactoryBot.create_list(:tag, GENERATE_TAGS_COUNT)