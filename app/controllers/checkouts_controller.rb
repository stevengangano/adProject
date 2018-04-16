class CheckoutsController < ApplicationController

  def new
    #because "buy button" in views/ads/info.html.erb
    #redirects to new_checkout_path(:ad_id => @ad.id),

    #URL = http://localhost:3000/checkouts/new?ad_id=60

    #passes same @ad.id from info.html.erb to this page
    @ad = Ad.find(params[:ad_id])

    #instance variable passed at top of form to
    #redirect to a certain page
    @checkout = Checkout.new
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
    #Needed so 'checkout_id' is updated when
    #user submits the form. Needed so '@ad' in
    #show action has 'checkout_id' updated
    @ad = Ad.find(params[:ad_id])

    #Once submit button is pressed, allows
    #'checkout_parmams' to go through

    @checkout = Checkout.new(checkout_params)
    @checkout.user = current_user
    #Save params and if bought left or equal to in stock
    if @checkout.save && @checkout.quantity.to_i <= @ad.quantity
        #This grabs 'id' from 'Checkout' (@checkout.id)
        #and updates ad with the same checkout_id
        #They both need to have the same checkout.id
        #so same ad info displays to next screen
        @ad.update_attributes(checkout_id: @checkout.id)
        redirect_to checkout_path(@checkout)
    else
      render :new
      flash[:notice] = "There is not enough in stock"
      #prevents flash notice from showing when redirect to
      #checkout_path(@checkout)
    end

    puts @checkout.inspect
    #Displays: <Checkout id: 11, address: nil, city: "fds", postal_code: "fd", state: "fd", created_at: "2018-04-12 19:11:52", updated_at: "2018-04-12 19:11:52", user_id: 2, quantity: 3>
    puts @ad.inspect
    #Displays: <Ad id: 1, title: "Macbook", price: "2,532.43", description: "Macbook", ad_image: "macbook.jpg", created_at: "2018-04-12 18:19:43", updated_at: "2018-04-12 19:13:35", status: 1, user_id: 1, category_id: 1, detail_id: nil, checkout_id: 13>
  end

  def show
    #Displays data from 'Checkout' model
    #Needed because URL is checkouts/:id
    @checkout_info = Checkout.find(params[:id])

    #Displays data from 'Ad' model

    #@checkout_info.ads because of association created
    #between 'Checkout' and 'Ads'

    #@checkout_info grabs the 'checkout' ID and grabs
    #Ad associated with that.

    #Can use either first or last since there is only 1
    #'ads' checkout.id is updated from create action
    @ad =  @checkout_info.ads.first
    @amount = @ad.price * @checkout_info.quantity.to_f
  end



  def checkout_params
    params.require(:checkout).permit(:address,
                               :city,
                               :postal_code,
                               :state,
                               :quantity)
  end

end
