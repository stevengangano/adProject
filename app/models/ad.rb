class Ad < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  enum status: { draft: 0, published: 1 }
  mount_uploader :ad_image, AvatarUploader

  validates_presence_of :title, :price, :description, :ad_image
  private
  def avatar_size_validation
   errors[:ad_image] << "should be less than 1MB" if avatar.size > 1.megabytes
  end
end
