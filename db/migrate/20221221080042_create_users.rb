class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.integer :total
      t.bigint :phone 

      t.timestamps
    end
  end
end
