# frozen_string_literal: true

# Migration add unique index to post_tags table.
class AddUniqueIndexToPostTags < ActiveRecord::Migration[6.1]
  def change
    add_index :post_tags, %i[post_id tag_id], unique: true
  end
end
