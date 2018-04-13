class Category < ActiveRecord::Base
  has_many :ads

  def self.recent
    order("created_at DESC")
  end

  enum status: { draft: 0, published: 1 }

  #show categories only with ads in them
  def self.with_ads
    includes(:ads).where.not(ads: { id: nil })
  end

end
