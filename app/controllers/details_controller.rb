class DetailsController < ApplicationController
  def index
  end

  def new
    @address = Detail.new
  end

  # Posts an article from (articles/new)
  def create
    #render plain: params[:article].inspect
    @ad = Detail.new
    # @article.user = current_user
    @ad.user = current_user
    if @ad.save
        flash[:notice] = ""
        redirect_to detail_path(@ad)
    else
      render :new
    end
  end

  def show
    # @portfolio = Portfolioo.find(params[:id])
    @ad = Detail.find(params[:id])
  end


end
