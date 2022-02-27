class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:checkout, :show]

  def show
    @order = Order.find(session[:order_id])
    @items_total_pricess = []
    @order.item_orders.each do |item_order|
      @items_total_pricess << (item_order.item.price * item_order.quantity)
    end
  end

  def checkout
  end

end
