class RemoveFieldsFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :net_state, :timestamp
    remove_column :users, :profile_id, :integrate
    
  end
end
