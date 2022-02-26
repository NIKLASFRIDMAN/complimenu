class ItemOrdersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :find_order

  def create
    item_order = ItemOrder.new(quantity: 1)
    item_order.item_id = params[:item_id]
    item_order.order_id = @order.id
    respond_to do |format|
      item_order.save
      format.html { redirect_to items_path }
      format.json
    end
  end

  def destroy
    item_order = ItemOrder.find_by(item_id: params[:id], order_id: session[:order_id])
    if item_order.present?
      item_order.destroy
      redirect_to items_path
    end
  end

  def update
    @item_order = ItemOrder.find(params[:id])
    @item_order.quantity += params[:quantity].to_i
    @item_order.save
    redirect_to items_path
  end

  def find_order
    @order = Order.find(session[:order_id])
  end
end
