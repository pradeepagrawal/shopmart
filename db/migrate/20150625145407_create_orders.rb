class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.string :address
      t.decimal :total
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :users
  end
end
