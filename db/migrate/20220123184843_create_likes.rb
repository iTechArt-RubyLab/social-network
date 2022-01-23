class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :likable, polymorphic: true
      t.timestamps
    end
  end
end
