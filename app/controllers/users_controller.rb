class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_ads = @user.ads
  end

  def sold
    @user = User.find(params[:id])
  end


end
