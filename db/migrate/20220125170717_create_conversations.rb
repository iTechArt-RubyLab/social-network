class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.string :name

      t.timestamps
    end
    add_index :conversations, :name, unique: true
  end
end
