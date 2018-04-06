class AddCategoryReferenceToAds < ActiveRecord::Migration
  def change
    add_reference :ads, :category, index: true, foreign_key: true
  end
end
