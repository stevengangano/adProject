class ChangePriceToFloat < ActiveRecord::Migration
  def change
    change_column :ads, :price, :float
  end
end
