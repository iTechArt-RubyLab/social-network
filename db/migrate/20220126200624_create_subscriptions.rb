# frozen_string_literal: true

# Migration create subscriptions table in database.
class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :subscriber, null: false, foreign_key: { to_table: :users }
      t.references :signatory, null: false, foreign_key: { to_table: :users }
      t.boolean :status, null: false, default: false

      t.timestamps
    end

    add_index :subscriptions, %i[subscriber_id signatory_id], unique: true
  end
end
