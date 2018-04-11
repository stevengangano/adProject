class CheckoutsController < ApplicationController

  def new
    @address = Checkout.new

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


  def show
    @ad = Checkout.find(params[:id])
  end

  def checkout_params
    params.require(:checkout).permit(:address,
                               :city,
                               :postal_code,
                               :state)
  end

end
