# frozen_string_literal: true

# add conversation to messages migration
class AddConversationToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :conversation, foreign_key: true
  end
end
