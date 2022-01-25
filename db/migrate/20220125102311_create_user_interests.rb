# frozen_string_literal: true

# Migration create user interests table in database.
class CreateUserInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :user_interests do |t|
      t.belongs_to :profile
      t.belongs_to :tag

      t.timestamps
    end

    add_index :user_interests, %i(profile_id tag_id), unique: true
  end
end
