class CreateConsumptions < ActiveRecord::Migration
  def change
    create_table :consumptions do |t|
      t.integer :sequence_number
      t.float :value
      t.references :bill, :null => false

      t.timestamps
    end
    add_index :consumptions, :bill_id
  end
end
