class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   #name must always be entered on the form
   validates_presence_of :password,

   def names
     #Takes the first and last name, splits them, and then grabs 1st element
     #in the array.
     #For example:
     #Go to rails console => type User.all => User.last => user = User.last =>
     # => user.first_name => "John"
     #self.name grabs the entire name string
     first_name + ' ' + last_name
   end

end
