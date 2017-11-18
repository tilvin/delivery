class CreatePoints < ActiveRecord::Migration[5.1]
  def change
    create_table :points do |t|
      t.string :name
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
