class AddSumToNumbers < ActiveRecord::Migration[7.0]
  def change
    add_column :numbers, :sum, :integer
  end
end
