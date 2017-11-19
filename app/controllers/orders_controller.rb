class OrdersController < ApplicationController

  before_action :set_order

  def index
    @orders = Order.where(restaurant: current_user.restaurant).order(created_at: :desc)
  end

  def show
    authorize! :read, @order
  end

  def new
    @order = Order.new
    authorize! :create, @order
  end

  def create
    @order = Order.new(order_params)
    @order.restaurant = current_user.restaurant
    @order.user = current_user
    authorize! :create, @order
    if @order.save
      @order.notify_delivery_service(@order)
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def set_accepted
    if params[:token] == @order.token
      @order.update(state: 'accepted')
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :phone, :name, :street, :house, :flat, :floor, :intercom, :by_time, :entrance,
      :point_id, :comment, :state
    )
  end

  def set_order
    @order = Order.find(params[:id]) if params[:id]
  end

end
