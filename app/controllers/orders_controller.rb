class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:checkout, :show]

  def show
    @order = Order.find(session[:order_id])
    @all_items_total_price = 0
    @order.item_orders.each do |item_order|
      @all_items_total_price += (item_order.item.price * item_order.quantity)
    end
    @all_items_total_price = @all_items_total_price.round(2)
  end

  def checkout
  end
end
