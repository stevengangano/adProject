class FixColumn < ActiveRecord::Migration
  def change
    change_column :ads, :price, :string, using: 'price::string', limit: 8
  end
end
