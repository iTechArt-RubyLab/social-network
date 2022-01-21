# frozen_string_literal: true

# Migration add unique index to user_interests table.
class AddUniqueIndexToUserInterests < ActiveRecord::Migration[6.1]
  def change
    add_index :user_interests, %i[profile_id tag_id], unique: true
  end
end
