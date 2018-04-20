class Ad < ActiveRecord::Base
  after_initialize :set_defaults
  belongs_to :user
  belongs_to :category
  belongs_to :checkout
  validates :user_id, presence: true

  enum status: { draft: 0, published: 1 }
  mount_uploader :ad_image, AvatarUploader

  validates_presence_of :title, :price, :description

  def self.recent
    order("created_at DESC")
  end

  def set_defaults
    self.ad_image ||= "http://placehold.it/200x200"
  end

  scope :item_is_in_stock, -> {where("quantity > ?", 0)}


  private
  def avatar_size_validation
   errors[:ad_image] << "should be less than 1MB" if avatar.size > 1.megabytes
  end
end
