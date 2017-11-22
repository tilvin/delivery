class Admin::OrdersController < ApplicationController

  before_action :set_order

  def index
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
    @q = Order.all.order(created_at: :desc).ransack(params[:q])
    @orders = @q.result
  end

  def show
  end

  def edit
  end

  def update
    if @order.update(order_params)
      if @order.versions.last.changeset[:state]
        @order.notify_restaurant(@order)
      end
      redirect_to admin_order_path(@order)
    else
      puts "#{ @order.errors.full_messages }"
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :phone, :name, :street, :house, :flat, :floor, :intercom, :by_time, :entrance,
      :point_id, :comment, :state, :price, :delivery_price
    )
  end

  def set_order
    @order = Order.find(params[:id]) if params[:id]
  end

end
