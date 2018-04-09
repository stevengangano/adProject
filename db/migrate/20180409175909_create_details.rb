class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :state

      t.timestamps null: false
    end
  end
end
