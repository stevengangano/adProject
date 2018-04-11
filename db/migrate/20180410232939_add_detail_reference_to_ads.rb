class AddDetailReferenceToAds < ActiveRecord::Migration
  def change
    add_reference :ads, :detail, index: true, foreign_key: true
  end
end
