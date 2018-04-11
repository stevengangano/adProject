class AddCheckoutReferenceToAds < ActiveRecord::Migration
  def change
    add_reference :ads, :checkout, index: true, foreign_key: true
  end
end
