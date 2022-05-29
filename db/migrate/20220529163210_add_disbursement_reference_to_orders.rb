class AddDisbursementReferenceToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :disbursement, index: true
  end
end
