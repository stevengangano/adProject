class CategoriesController < ApplicationController
  before_action :set_sidebar_categories, only: [:index, :show]

  def index
    @categories = Category.all
    @ads = Ad.published.recent.page(params[:page]).per(6)

  end

  def show
    @category = Category.find(params[:id])
    @ads = @category.ads.all.recent.published.page(params[:page]).per(6)
  end

  private
  def set_sidebar_categories
    @side_bar_categories = Category.with_ads
  end

end
