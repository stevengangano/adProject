class ChargesController < ApplicationController
  def index
  end

  def new
    @checkout_info = Checkout.find(params[:id])
    @ad = Ad.find(params[:ad_id])
  end

  def create
    byebug
    @checkout_info = Checkout.find(params[:id])
    @ad = Ad.find(params[:ad_id])

    #Update quantity
    @update_qty = @ad.quantity - @checkout_info.quantity.to_i
    @ad.update_attributes(quantity: @update_qty.to_i)

    # Amount in cents
    @amount = 100 * @ad.price.to_i

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    redirect_to charge_path(@checkout_info)
    flash[:notice] = 'Payment successful'

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_error_path
  end


  def show
  end
end
