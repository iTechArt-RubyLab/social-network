# frozen_string_literal: true

# Migration create conversations table in database.
class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
