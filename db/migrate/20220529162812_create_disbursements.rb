class CreateDisbursements < ActiveRecord::Migration[6.1]
  def change
    create_table :disbursements do |t|
      t.references :merchant, index: true

      t.integer :week, null: false
      t.integer :year, null: false
      t.decimal :amount, null: false

      t.timestamps
    end

    add_index :disbursements, %i[merchant_id year week], unique: true
  end
end
