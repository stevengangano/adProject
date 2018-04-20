class ChargesController < ApplicationController
  def index
  end

  def new
    @checkout_info = Checkout.find(params[:id])
    @ad = Ad.find(params[:ad_id])
  end

  def create
    @checkout_info = Checkout.find(params[:id])
    @ad = Ad.find(params[:ad_id])


    # Amount in cents
    @amount = (@ad.price.to_i * 100 * @checkout_info.quantity.to_i).to_i

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => @ad.title,
      :currency    => 'usd'
    )
    #If buyer buys less or equal to stock amount
    if @checkout_info.quantity.to_i <= @ad.quantity
      #Update quantity
      @update_qty = @ad.quantity - @checkout_info.quantity.to_i
      @ad.update_attributes(quantity: @update_qty.to_i)
      redirect_to charge_path(@checkout_info)
      flash[:notice] = 'Payment successful'
    elsif
      flash[:error] = 'There are no items left in stock'
      render :new
    end

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_error_path
  end


  def sold
    @user = User.find(params[:id])
    @user_ads = @user.ads
    @user_checkouts = @user.checkouts

  end

end

# pass info from create

# image
# title
# checkout_info.quantity = sold quantity
# @amount = (@ad.price.to_i * 100 * @checkout_info.quantity.to_i).to_i
