class CategoriesController < ApplicationController
  # before_action :user_ad_info, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @ads = @category.ads.all #can add pagination and recent
  end

end
