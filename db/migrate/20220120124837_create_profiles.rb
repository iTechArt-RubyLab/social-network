# frozen_string_literal: true

# CreateUser migration
class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :surname, null: false
      t.string :name, null: false
      t.string :patronymic
      t.date :birthday, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :phone, limit: 15, index: { unique: true }
      t.text :about
      t.boolean :hidden, null: false, default: false
      t.boolean :verified, null: false, default: false

      t.timestamps
    end
  end
end
