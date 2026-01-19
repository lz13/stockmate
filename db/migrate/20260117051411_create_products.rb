class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products, id: :uuid do |t|
      t.references :shop, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.integer :price_in_cents, null: false, default: 0
      t.string :sku
      t.integer :stock_quantity, null: false, default: 0
      t.integer :minimum_quantity, null: false, default: 0

      t.timestamps
    end

    add_index :products, [:shop_id, :name], unique: true
  end
end
