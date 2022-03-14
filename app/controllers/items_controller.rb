class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_table, :find_users
  def index
    redirect_to "#{table_items_path(@table)}##{params[:format].downcase}" if params[:format]
    @category_items = Item.all
    @category_items = @category_items.sort_by {|item| item.total_reviews}.reverse
    @category_items = @category_items.group_by { |item| item.category }
    @item_orders = ItemOrder.grouped_by_item(session[:order_id])
    @total_items = total_items(@item_orders)
    @users = User.where(table_id: @table.id)
  end

  private

  def find_users
    @users = User.where(table_id: @table.id)
  end

  def find_table
    @table = Table.find(params[:table_id])
  end

  def total_items(itemorders)
    total_items = 0
    itemorders.each do |_item, itemorder_item|
      itemorder_item.each do |itemorder|
        total_items += itemorder.quantity
      end
    end
    return total_items
  end
end
