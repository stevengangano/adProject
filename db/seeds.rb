# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create! :first_name => 'John', :last_name => 'Doe', :email => 'johndoe@yahoo.com', :password => 'skating88', :password_confirmation => 'skating88'
User.create! :first_name => 'Steven', :last_name => 'Gangano', :email => 'stevengangano@yahoo.com', :password => 'skating88', :password_confirmation => 'skating88'


 Category.create!(
 	title: 'Misc',
 )
 Category.create!(
	title: 'Toys',
)
Category.create!(
	title: 'Electronics',
)


60.times do
 Ad.create!(
   title: Faker::App.name,
   quantity: 5,
   description: Faker::Lorem.paragraph + Faker::Lorem.paragraph + Faker::Lorem.paragraph,
   price: Faker::Number.decimal(2),
   category_id: 1,
   user_id: 1,
   status: 1,
   ad_image: File.open(File.join(Rails.root, 'app/assets/images/stock_image.png'))
 )
end
