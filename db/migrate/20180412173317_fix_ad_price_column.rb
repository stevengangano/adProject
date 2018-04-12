class FixAdPriceColumn < ActiveRecord::Migration
  def up
   change_column :ads, :price, :string, default: 0, limit: 8
  end

  def down
   change_column :ads, :price, :string, default: nil
  end
end
