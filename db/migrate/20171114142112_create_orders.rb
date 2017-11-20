class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :phone
      t.string :name
      t.string :street
      t.string :house
      t.integer :entrance
      t.string :flat
      t.integer :floor
      t.string :intercom
      t.datetime :by_time
      t.text :comment
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :point_id
      t.integer :state, default: 0
      t.string :token
      t.decimal :price

      t.timestamps
    end
  end
end
