class User < ActiveRecord::Base
  has_many :ads

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   #name must always be entered on the form
   validates_presence_of :first_name, :last_name

   mount_uploader :avatar, AvatarUploader

   def firstName
     #Takes the first and last name, splits them, and then grabs 1st element
     #in the array.
     #For example:
     #Go to rails console => type User.all => User.last => user = User.last =>
     # => user.first_name => "John"
     #self.name grabs the entire name string
     first_name
   end

   def lastName
     #Takes the first and last name, splits them, and then grabs 1st element
     #in the array.
     #For example:
     #Go to rails console => type User.all => User.last => user = User.last =>
     # => user.first_name => "John"
     #self.name grabs the entire name string
     last_name
   end

   private
   def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
   end

end
