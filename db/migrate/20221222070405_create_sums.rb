class CreateSums < ActiveRecord::Migration[7.0]
  def change
    create_table :sums do |t|

      t.timestamps
    end
  end
end
