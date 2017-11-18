class Admin::RestaurantsController < ApplicationController

  before_action :set_restaurant

  def index
    @restaurants = Restaurant.all
  end

  def show
    @points = @restaurant.points
  end

  def new
    @restaurant = Restaurant.new
    authorize! :create, Restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    authorize! :create, Restaurant
    if @restaurant.save
      redirect_to admin_restaurants_path
    else
      render :new
    end
  end

  def edit
    authorize! :update, Restaurant
  end

  def update
    authorize! :update, Restaurant
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurants_path
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, Restaurant
    @restaurant.destroy
    redirect_to admin_restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id]) if params[:id]
  end

end
