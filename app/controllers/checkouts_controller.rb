class CheckoutsController < ApplicationController
  before_action :find_ad, only: :show

  def new
    @ad = Ad.find(params[:ad_id])
    @address = Checkout.new
    if current_user.nil?
      redirect_to(new_user_session_path)
      flash[:notice] = "Please login or register to purchase"
    end
    if current_user == @ad.user
    redirect_to(root_path)
    flash[:notice] = "You cannot buy your own ad"
    end
  end

  def create
    @ad = Checkout.new(checkout_params)
    @ad.user = current_user
    if @ad.save
        flash[:notice] = ""
        redirect_to checkout_path(@ad)
    else
      render :new
    end
  end

  #Intead of show, use update next time
  def update

  end

  def show
    @checkout_info = Checkout.find(params[:id])
    @checkout_info.update_attributes(checkout_params)
  end

  def find_ad
    @ad = Ad.find(params[:ad_id])
  end

  def checkout_params
    params.require(:checkout).permit(:address,
                               :city,
                               :postal_code,
                               :state,
                               :quantity)
  end

end
