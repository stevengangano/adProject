class FixPriceColumn < ActiveRecord::Migration
  def change
    change_column :ads, :price, :decimal, limit: 8
  end
end
