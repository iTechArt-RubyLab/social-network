class CreateUsersConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :users_conversations do |t|
      t.references :conversation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
