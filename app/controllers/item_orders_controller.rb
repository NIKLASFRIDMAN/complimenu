class ItemOrdersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :find_order, only: [:create]
  before_action :find_table

  def create
    @item_order = ItemOrder.new(quantity: 1)
    @item_order.item_id = params[:item_id]
    @item_order.order_id = @order.id
    @item_order.save
    @quantity = 1
    # @item = @item_order.item
    TableroomChannel.broadcast_to(
        @table,
        render(:update)
    )
    respond_to do |format|
      format.html { redirect_to table_items_path(@table) }
      format.json { }
    end
  end

  def destroy
    item_order = ItemOrder.find_by(id: params[:id])
    @item = item_order.item
    item_order.destroy
    @quantity = -1
    TableroomChannel.broadcast_to(
        @table,
        render(:destroy)
    )
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { }
    end
  end

  def update
    @item_order = ItemOrder.find(params[:id])
    @item_order.quantity += params[:quantity].to_i
    @quantity = params[:quantity].to_i
    @item_order.save
    TableroomChannel.broadcast_to(
      @table,
      render(:update)
    )
    respond_to do |format|
      format.html { redirect_to table_items_path(@table) }
      format.json { }
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
