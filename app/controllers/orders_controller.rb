class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:checkout, :show]

  def show
    @order = Order.find(session[:order_id])
  end

  def checkout
  end

  def total
    @order = Order.find(session[:order_id])
  end
end
