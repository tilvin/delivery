class Admin::PointsController < ApplicationController

  before_action :set_point
  before_action :set_restaurant

  def new
    @point = Point.new
    authorize! :create, Point
  end

  def create
    @point = @restaurant.points.new(point_params)
    authorize! :create, Point
    if @point.save
      redirect_to admin_restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def edit
    authorize! :update, Point
  end

  def update
    authorize! :update, Point
    if @point.update(point_params)
      redirect_to admin_restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @point
    @point.destroy
    redirect_to admin_restaurant_path(@restaurant)
  end

  private

  def point_params
    params.require(:point).permit(:name, :restaurant_id)
  end

  def set_point
    @point = Point.find(params[:id]) if params[:id]
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
