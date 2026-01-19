class CreateShops < ActiveRecord::Migration[8.1]
  def change
    create_table :shops, id: :uuid do |t|
      t.string :name, null: false
      t.string :location
      t.references :owner, null: false, type: :uuid, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :shops, :name
  end
end
