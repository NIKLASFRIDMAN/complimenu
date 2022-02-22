class ItemOrdersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :find_order

  def create
    item_order = ItemOrder.new(quantity: 1)
    item_order.item_id = params[:item_id]
    item_order.order_id = @order.id
    item_order.save!
    redirect_to items_path
  end

  def find_order
    @order = Order.find(session[:order_id])
  end
end
