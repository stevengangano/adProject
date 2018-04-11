class Category < ActiveRecord::Base
  has_many :ads

  def self.recent
    order("created_at DESC")
  end

  #show categories only with ads in them
  def self.with_ads
    includes(:ads).where.not(ads: { id: nil })
  end

end
