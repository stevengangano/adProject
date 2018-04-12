class CheckoutsController < ApplicationController
  before_action :find_ad, only: :create

  def new
    @ad = Ad.find(params[:ad_id])
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
    @checkout = Checkout.new(checkout_params)
    @checkout.user = current_user
    if @checkout.save
        #Updates 'checkout_id' in Ad.
        @ad.update_attributes(checkout_id: @checkout.id)
        redirect_to checkout_path(@checkout)
    else
      render :new
    end

    puts @checkout.inspect
    #Displays: <Checkout id: 11, address: nil, city: "fds", postal_code: "fd", state: "fd", created_at: "2018-04-12 19:11:52", updated_at: "2018-04-12 19:11:52", user_id: 2, quantity: 3>
    puts @ad.inspect
    #Displays: <Ad id: 1, title: "Macbook", price: "2,532.43", description: "Macbook", ad_image: "macbook.jpg", created_at: "2018-04-12 18:19:43", updated_at: "2018-04-12 19:13:35", status: 1, user_id: 1, category_id: 1, detail_id: nil, checkout_id: 13>
  end

  #Intead of show, use update next time
  def update

  end

  def show
    #Checkout info
    @checkout_info = Checkout.find(params[:id])
    #Ads info. Because an association was created
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
