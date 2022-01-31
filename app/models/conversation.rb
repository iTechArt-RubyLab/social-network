# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Conversation < ApplicationRecord
  has_many :user_conversations
  has_many :users, through: :user_conversations, dependent: :destroy

  has_many :messages

  validates :name, presence: true
end
