class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def set_accepted
    @order = Order.find(params[:id])
    if @order.init?
      @order.update(state: 'accepted')
      @order.notify_restaurant(@order)
      redirect_to admin_orders_path
    else
      redirect_to admin_orders_path
    end
  end

end
