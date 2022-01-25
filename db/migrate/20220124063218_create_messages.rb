# frozen_string_literal: true

# CreateMessage migration
class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :text, null: false
      t.references :user, null: false, foreign_key: true
      t.belongs_to :conversation

      t.timestamps null: false
    end
  end
end
