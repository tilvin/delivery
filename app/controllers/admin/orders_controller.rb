class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def set_accepted
    Order.find(params[:id]).update(state: 'accepted')
    redirect_to admin_orders_path
  end

end
