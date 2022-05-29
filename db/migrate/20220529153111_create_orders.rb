class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :amount, null: false
      t.timestamp :completed_at
      t.references :shopper, index: true
      t.references :merchant, index: true

      t.timestamps
    end
  end
end
