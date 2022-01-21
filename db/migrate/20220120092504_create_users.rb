# frozen_string_literal: true

# CreateUser migration
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :status, null: false, default: 0
      t.timestamp :net_state, null: false
      t.integer :profile_id, null: false, index: { unique: true }

      t.timestamps
    end
    add_check_constraint :users, 'status in (0,1)', name: 'check_user_status'
  end
end
