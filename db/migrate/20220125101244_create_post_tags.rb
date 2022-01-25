# frozen_string_literal: true

# Migration create post tags table in database.
class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.belongs_to :post
      t.belongs_to :tag

      t.timestamps
    end

    add_index :post_tags, %i(post_id tag_id), unique: true
  end
end
