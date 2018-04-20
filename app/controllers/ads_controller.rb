class AdsController < ApplicationController
  #instead of application.html.erb, it uses portfolio.html.erb
  # layout "portfolio"
  # before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
  # access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all
  before_filter :authenticate, :except => [:index, :new, :create, :show, :info, :details, :toggle_status]
  before_action :set_sidebar_categories, only: [:index]

  def index
    @ads = Ad.published.recent.item_is_in_stock.page(params[:page]).per(9)
  end

  def new
    @ad = Ad.new
  end

  def create
    #allows the "ad_params" to be passed into "AD.new"
    #after submit action is clicked
    #This is passed to show action so
    #Ad.find(params[:id]) can be used
    @ad = Ad.new(ad_params)
    #Post will be saved under the current_user
    @ad.user = current_user
    if @ad.save
        redirect_to ad_path(@ad)
    else
      render 'new'
    end
  end

  # def edit
  #   # @portfolio = Portfolioo.find(params[:id])
  # end

  # def update
  #   #updates the params in the form
  #   if @portfolio.update(portfolio_params)
  #     flash[:notice] = "Article was successfully updated"
  #     redirect_to portfolio_path
  #   else
  #     render :edit
  #   end
  # end

  def show
    #Once "AD" is created, this grabs "Ad.id" which is
    #passed into the URL "ads/:id"

    #Ad.find(params[:id]) is available because of Ad.new(ad_params)
    #create action

    #@ad displays that particular info for that "Ad"
    @ad = Ad.find(params[:id])
  end


  def info
    #params is needed because of "ads/:id/info"
    @ad = Ad.find(params[:id])
  end

  #no template
  # def destroy
  #   # @portfolio = Portfolioo.find(params[:id])
  #   @portfolio.destroy
  #   flash[:notice] = "Article was successfully deleted"
  #   redirect_to portfolio_path
  # end

  def toggle_status
    @ad = Ad.find(params[:id])
    @ad.published! if @ad.draft?
    flash[:notice] = "Ad was succesfully posted"
    redirect_to root_path
  end

  private
  #method to add data to the database
    def ad_params
      params.require(:ad).permit(:title,
                                 :price,
                                 :description,
                                 :ad_image,
                                 :avatar_cache,
                                 :remove_avatar,
                                 :category_id,
                                 :quantity)
    end

    def set_sidebar_categories
      @side_bar_categories = Category.with_ads
    end

end
