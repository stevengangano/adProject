class AdsController < ApplicationController
  #instead of application.html.erb, it uses portfolio.html.erb
  # layout "portfolio"
  # before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
  # access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all
  before_filter :authenticate, :except => [:index, :new, :create, :show, :info, :details, :toggle_status]
  before_action :set_sidebar_categories, only: [:index]

  def index
    @ads = Ad.published.recent.page(params[:page]).per(9)
    # @portfolios = Portfolioo.all
    # @portfolio = Portfolioo.paginate(page: params[:page], per_page: 5)
  end

  def new
    @ad = Ad.new
  end

  # Posts an article from (articles/new)
  def create
    #render plain: params[:article].inspect
    @ad = Ad.new(ad_params)
    # @article.user = current_user
    @ad.user = current_user
    if @ad.save
        flash[:notice] = ""
        redirect_to ad_path(@ad)
    else
      render :new
    end
  end

  # def edit
  #   # @portfolio = Portfolioo.find(params[:id])
  # end

  # #no template
  # def update
  #   # @portfolio = Portfolioo.find(params[:id])
  #   if @portfolio.update(portfolio_params)
  #     flash[:notice] = "Article was successfully updated"
  #     redirect_to portfolio_path
  #   else
  #     render :edit
  #   end
  # end

  def show
    # @portfolio = Portfolioo.find(params[:id])
    @ad = Ad.find(params[:id])
  end


  def info
    @ad = Ad.find(params[:id])
  end

  def details #"def new"
    @ad = Ad.find(params[:id])
    @address = Detail.new
    redirect_to(new_user_session_path) if current_user.nil?
    redirect_to(root_path) if current_user == @ad.user
  end

  def create_address #"def create"
    #render plain: params[:article].inspect
    @ad = Detail.new(detail_params)
    # @article.user = current_user
    @ad.user = current_user
    if @ad.save
        redirect_to checkout(@ad)
    else
      render :details
    end
  end

 def checkout #"def show"
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
                                 :category_id)
    end

    def detail_params
      params.require(:detail).permit(:address,
                                 :city,
                                 :postal_code,
                                 :state)
    end

    def set_sidebar_categories
      @side_bar_categories = Category.with_ads
    end

end
