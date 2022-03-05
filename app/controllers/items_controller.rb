class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_table
  def index
    redirect_to "#{table_items_path(@table)}##{params[:format].downcase}" if params[:format]
    @category_items = Item.grouped_by_category
    @item_orders = ItemOrder.grouped_by_item(session[:order_id])
  end

  private

  def find_table
    @table = Table.find(params[:table_id])
  end
end
