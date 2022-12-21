class CreateNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :numbers do |t|
      t.integer :numberA
      t.integer :numberB

      t.timestamps
    end
  end
end
