# frozen_string_literal: true

# remove fileds migration
class RemoveFieldsFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :net_state, :timestamp
    remove_column :users, :profile_id, :integer
  end
end
