class FixColumnName < ActiveRecord::Migration
  def change
    change_column :ads, :price, :decimal
  end

end
