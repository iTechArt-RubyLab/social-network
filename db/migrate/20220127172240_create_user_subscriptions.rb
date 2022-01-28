# frozen_string_literal: true

# Migration create user subscriptions table in database.
class CreateUserSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_subscriptions do |t|
      t.references :subscriber, null: false, foreign_key: { to_table: :users }
      t.references :subscription, null: false, foreign_key: { to_table: :users }
      t.boolean :status, null: false, default: false

      t.timestamps
    end

    add_index :user_subscriptions, %i[subscriber_id subscription_id], unique: true
    add_check_constraint :user_subscriptions, 'subscriber_id <> subscription_id', name: 'check_subscriber_and_subscription_equality'
  end
end
