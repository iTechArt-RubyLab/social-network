# frozen_string_literal: true

# CreatePosts migration
class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user
      t.text :body, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_check_constraint :posts, 'length(body) > 2 and 280 > length(body)', name: 'check_body_lenght'
    add_check_constraint :posts, 'status in (0,1)', name: 'check_post_status'
  end
end
