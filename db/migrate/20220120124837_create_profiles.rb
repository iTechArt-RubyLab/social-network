# frozen_string_literal: true

# CreateUser migration
class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :surname, null: false
      t.string :name, null: false
      t.string :patronymic
      t.date :birthday, null: false
      t.string :email, null: false
      t.string :phone, :limit 15
      t.text :about
      t.boolean :hidden, null: false, default: false
      t.boolean :verified, null: false, default: false
      # rubocop:disable Layout/LineLength
      t.timestamps
    end
    add_index :profiles, :email, unique: true
    add_index :profiles, :phone, unique: true
      # rubocop:enable Layout/LineLength
  end
end
