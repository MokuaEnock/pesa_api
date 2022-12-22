class CreateSums < ActiveRecord::Migration[7.0]
  def change
    create_table :sums do |t|
      t.integer :sum
      t.integer :difference

      t.timestamps
    end
  end
end
