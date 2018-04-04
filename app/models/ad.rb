class Ad < ActiveRecord::Base

  mount_uploader :ad_image, AvatarUploader


  private
  def avatar_size_validation
   errors[:ad_image] << "should be less than 1MB" if avatar.size > 1.megabytes
  end
end
