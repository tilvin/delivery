class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.integer :restaurant_id
      t.integer :role, default: 1

      t.timestamps                :null => false
    end

    add_index :users, :email, unique: true
  end
end
