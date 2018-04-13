class AddQuantityToAds < ActiveRecord::Migration
  def change
    add_column :ads, :quantity, :integer
  end
end
