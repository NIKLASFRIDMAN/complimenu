class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:checkout, :show, :waiter]
  before_action :find_order, :calculate_total, only: [:show, :checkout]

  def show; end

  def checkout; end

  def waiter; end

  private

  def find_order
    @order = Order.find(session[:order_id])
  end

  def calculate_total
    @all_items_total_price = 0
    @order.item_orders.each do |item_order|
      @all_items_total_price += (item_order.item.price * item_order.quantity)
    end
    @all_items_total_price = @all_items_total_price.round(2)
  end

end
