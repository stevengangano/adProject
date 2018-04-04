class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title
      t.string :string
      t.string :price
      t.text :description
      t.string :ad_image

      t.timestamps null: false
    end
  end
end
