# frozen_string_literal: true

# add field migration
class AddUserToProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :profiles, :user, null: false, foreign_key: true
  end
end
