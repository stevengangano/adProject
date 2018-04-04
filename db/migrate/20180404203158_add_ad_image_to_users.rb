class AddAdImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ad_image, :string
  end
end
