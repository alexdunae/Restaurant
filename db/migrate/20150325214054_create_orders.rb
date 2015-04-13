class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total
      t.references :client, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
