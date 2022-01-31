# frozen_string_literal: true

# remove field migration
class RemoveEmailFromProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :email, :string
  end
end
