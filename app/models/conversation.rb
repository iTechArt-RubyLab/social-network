# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conversations_on_name  (name) UNIQUE
#
class Conversation < ApplicationRecord
  has_many :users_conversations, dependent: :destroy, inverse_of: :conversation
  validates :name, presence: true
end
