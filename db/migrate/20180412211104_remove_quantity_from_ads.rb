class RemoveQuantityFromAds < ActiveRecord::Migration
  def change
    remove_column :ads, :quantity
  end
end
