class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.references :picturable, polymorphic: true
      t.timestamps
    end
  end
end
