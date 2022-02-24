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

  def destroy
    item_order = ItemOrder.find_by(item_id: params[:id], order_id: session[:order_id])
    item_order.destroy
    redirect_to items_path
  end

  def decrease
    ItemOrder.find(params[:id]).decrement(:quantity).save!
    redirect_to items_path
  end

  def add
    ItemOrder.find(params[:id]).increment(:quantity).save!
    redirect_to items_path
  end

  def find_order
    @order = Order.find(session[:order_id])
  end
end
