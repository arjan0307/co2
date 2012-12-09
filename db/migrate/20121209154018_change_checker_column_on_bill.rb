class ChangeCheckerColumnOnBill < ActiveRecord::Migration
  def up
    change_column :bills, :checker_id, :integer, {:null => true}
  end

  def down
    change_column :bills, :checker_id, :integer, {:null => false}
  end
end
