class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.belongs_to :post
      t.belongs_to :tag

      t.timestamps
    end
  end
end
