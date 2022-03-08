class ItemOrdersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :find_order, only: [:create]
  before_action :find_table

  def create
    @item_order = ItemOrder.new(quantity: 1)
    @item_order.item_id = params[:item_id]
    @item_order.order_id = @order.id
    @item_order.save
    respond_to do |format|
      format.html { redirect_to table_items_path(@table) }
      format.json { render :update }
    end
  end

  def destroy
    item_order = ItemOrder.find_by(id: params[:id], order_id: session[:order_id])
    @item = item_order.item
    item_order.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { render :destroy }
    end
  end

  def update
    @item_order = ItemOrder.find(params[:id])
    @item_order.quantity += params[:quantity].to_i
    respond_to do |format|
      @item_order.save
      format.html { redirect_to table_items_path(@table) }
      format.json { render :update }
    end
  end

  private

  def find_order
    @order = Order.find(session[:order_id])
  end

  def find_table
    @table = Table.find(params[:table_id])
  end
end
