class DetailsController < ApplicationController
  def new
    @address = Detail.new
  end
end
