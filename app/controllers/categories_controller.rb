class CategoriesController < ApplicationController
  before_action :set_sidebar_categories, only: [:index, :show]

  def index
    @categories = Category.all
    @ads = Ad.published
  end

  def show
    @category = Category.find(params[:id])
    @ads = @category.ads.all #can add pagination and recent
  end

  private
  def set_sidebar_categories
    @side_bar_categories = Category.with_ads
  end

end
