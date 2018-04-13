# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create! :first_name => 'John', :last_name => 'Doe', :email => 'johndoe1@yahoo.com', :password => 'test123', :password_confirmation => 'test123'


 Category.create!(
   title: 'Misc'
 )

60.times do
 Ad.create!(
   title: Faker::App.name,
   ad_image: Faker::Avatar.image,
   description: Faker::Lorem.paragraph + Faker::Lorem.paragraph + Faker::Lorem.paragraph,
   price: Faker::Number.decimal(2),
   category_id: 1,
   user_id: 1,
   status: 1
 )
end
