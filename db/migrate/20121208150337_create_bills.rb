class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name
      t.date :period_start
      t.date :period_stop
      t.string :consumption_unit
      t.string :time_unit

      t.references :author, :null => false
      t.references :checker, :null => false

      t.timestamps
    end
    add_index :bills, :author_id
    add_index :bills, :checker_id
  end
end
