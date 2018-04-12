class AddQuantityToCheckouts < ActiveRecord::Migration
  def change
    add_column :checkouts, :quantity, :decimal
  end
end
