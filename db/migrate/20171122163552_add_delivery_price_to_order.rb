class AddDeliveryPriceToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery_price, :decimal
  end
end
