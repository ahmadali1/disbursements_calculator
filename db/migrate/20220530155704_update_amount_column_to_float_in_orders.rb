class UpdateAmountColumnToFloatInOrders < ActiveRecord::Migration[6.1]
  # TODO: add down method for rollback
  def change
    change_column :orders, :amount, :float
    change_column :disbursements, :amount, :float
  end
end
