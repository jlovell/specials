class RestaurantsController < ApplicationController
  def index
  end

  def all
    @day = params[:day] || Date.current
    session[:latitude]  = params[:latitude]
    session[:longitude] = params[:longitude]
    @location = { latitude: session[:latitude], longitude: session[:longitude] }
    @restaurants = Restaurant.includes(:specials).merge(Special.for(@day))
      .near(@location.values).references(:specials).uniq.map(&:decorate)
    render layout: false
  end

  def show
    @restaurant = Restaurant.find(params[:id]).decorate
    @specials = @restaurant.specials.order(:day).group_by(&:day)
  end

  def show_specials
    @restaurant = Restaurant.find(params[:id]).decorate
    @specials = @restaurant.specials.order(:day).group_by(&:day)
    render partial: "show_specials"
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant].permit!)
    if @restaurant.save
      flash[:success] = "#{@restaurant.name} was created successfully!"
      redirect_to restaurant_path(@restaurant)
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
