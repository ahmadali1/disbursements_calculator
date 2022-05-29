class CreateMerchants < ActiveRecord::Migration[6.1]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.string :cif, null: false
      t.string :email, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
