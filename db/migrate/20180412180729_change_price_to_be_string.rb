class ChangePriceToBeString < ActiveRecord::Migration
  def change
    change_column :ads, :price, :string, limit: 8
  end
end
