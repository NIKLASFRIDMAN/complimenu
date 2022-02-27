class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:checkout, :show]

  def show
    @order = Order.find(session[:order_id])
    @all_items_total_price = []
    @order.item_orders.each do |item_order|
      @all_items_total_price << (item_order.item.price * item_order.quantity)
    end
  end

  def checkout
  end
end
