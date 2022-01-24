class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :text, null: false
      t.references :messageable, polymorphic: true
      t.timestamps
    end

    add_reference :messages, :user, foreign_key: true
  end
end
