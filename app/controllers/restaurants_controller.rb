class RestaurantsController < ApplicationController
  def index
  end

  def all
    @location = { latitude: params[:latitude], longitude: params[:longitude] }
    @restaurants = Restaurant.near([params[:latitude], params[:longitude]])
  end

  def new
    @restaurant = Restaurant.new
    @specials = 7.times.map { |i| @restaurant.specials.new(day: i) }
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant].permit!)
    if @restaurant.save!
      redirect_to root_path
    else
      render action: "hello"
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @specials = @restaurant.specials
  end

  def update
  end
end
