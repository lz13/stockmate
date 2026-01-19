class CreateStockMovements < ActiveRecord::Migration[8.1]
  def change
    create_table :stock_movements, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :change, null: false
      t.string :reason, null: false
      t.integer :movement_type, null: false, default: 0

      t.timestamps
    end
  end
end
