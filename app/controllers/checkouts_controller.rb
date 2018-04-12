class CheckoutsController < ApplicationController
  before_action :find_ad, only: :create

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
    @address = Checkout.new(checkout_params)
    @address.user = current_user
    if @address.save
        @ad.update_attributes(checkout_id: @address.id)
        redirect_to checkout_path(@address)
    else
      render :new
    end
  end

  #Intead of show, use update next time
  def update

  end

  def show
    @checkout_info = Checkout.find(params[:id])
    @ad =  @checkout_info.ads.first
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
