class RestaurantsController < ApplicationController
  def index
  end

  def all
    @day = params[:day] || Time.zone.today
    @location = { latitude: params[:latitude], longitude: params[:longitude] }
    @restaurants = Restaurant.joins(:specials).merge(Special.for(@day))
      .near([params[:latitude], params[:longitude]]).uniq
  end

  def new
    @restaurant = Restaurant.new
    @specials = 7.times.map { |i| @restaurant.specials.new(day: i) }
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant].permit!)
    if @restaurant.save
      flash[:success] = "#{@restaurant.name} was created successfully!"
      redirect_to root_path
    else
      flash[:error] = "There was an error creating #{@restaurant.name}."
      render action: "new"
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @specials = @restaurant.specials
    render 'new'
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(params[:restaurant].permit!)
      flash[:success] = "#{@restaurant.name} was updated successfully!"
      redirect_to root_path
    else
      flash[:error] = "There was an error updating #{@restaurant.name}."
      render action: "new"
    end
  end

  def destroy
    @rest = Restaurant.find(params[:id])
    @rest.destroy and flash[:info] = "#{@rest.name} was deleted successfully."
    redirect_to action: 'index'
  end
end
