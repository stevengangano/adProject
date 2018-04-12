class ChangeQuantityToInteger < ActiveRecord::Migration
  def change
    change_column :checkouts, :quantity, :integer
  end
end
