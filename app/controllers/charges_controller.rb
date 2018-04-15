class ChargesController < ApplicationController
  def index
  end

  def new
    @checkout_info = Checkout.find(params[:id])
    @ad = Ad.find(params[:ad_id])
  end

  def create
    # byebug
    # @ad = Ad.find(params[:ad_id])

    # Amount in cents
    @amount = 99

    # Get the credit card details submitted by the form
    customer = Stripe::Customer.create(
        :email => params[:email],
        :source  => params[:stripeToken]
    )

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      Stripe::Charge.create(
          :amount => @amount,
          :currency => 'usd',
          :customer => customer.id,
          :description => 'Example charge custom form'
      )
      redirect_to charges_path
      flash[:notice] = 'Thanks'
      # remember to create a thanks.html.erb page in view/charges :)

  rescue Stripe::CardError => e
    flash[:error] = 'This is an error from payment'
    redirect_to charges_path
  end

end


 def show
 end
end

