class CategoriesController < ApplicationController
  before_action :set_sidebar_categories, only: [:index, :show]

  def index
    @ads = Ad.published.recent.where("quantity > ?", 0).page(params[:page]).per(6)
  end

  def show

    # Category.find(params[:id]) b/c of categories/:id
    @category = Category.find(params[:id])

    #An association between ads and categories is needed to perform this

    #Category.find(params[:id]) creates a "category_id"

    #This displays all ads and gives every ad a "category_id"
    @ads = @category.ads.all.recent.published.where("quantity > ?", 0).page(params[:page]).per(6)
  end

  private
  def set_sidebar_categories
    @side_bar_categories = Category.with_ads
  end

end
