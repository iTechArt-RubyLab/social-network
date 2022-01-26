class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :subscriber_id, null: false
      t.references :signatory_id, null: false
      t.boolean :status, null: false, default: false

      t.timestamps
    end

    add_foreign_key :subscriptions, :users, column: :subscriber_id
    add_foreign_key :subscriptions, :users, column: :signatory_id
  end
end
