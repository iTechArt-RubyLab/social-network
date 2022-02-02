# frozen_string_literal: true

# Migration create user conversations table in database.
class CreateUserConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :user_conversations do |t|
      t.belongs_to :user
      t.belongs_to :conversation

      t.timestamps
    end

    add_index :user_conversations, %i[user_id conversation_id], unique: true
  end
end
