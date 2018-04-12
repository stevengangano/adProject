class FixColumnAdPrice < ActiveRecord::Migration
  def self.up
     change_column :ads, :price, :string, limit: 8
   end

   def self.down
     change_column :ads, :price, :integer, limit: 8
   end
end
