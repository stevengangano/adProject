class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @ad = Ad.find(params[:id])
    @category = Category.find(params[:id])

    @ads = @category.ads.all #can add pagination and recent
  end
end
