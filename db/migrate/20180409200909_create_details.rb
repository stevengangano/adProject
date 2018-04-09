class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :state
    end
  end
end
