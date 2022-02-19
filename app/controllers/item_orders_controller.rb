class ItemOrdersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :find_order

  def find_order
    @order = Order.find(session[:order_id])
  end
end
