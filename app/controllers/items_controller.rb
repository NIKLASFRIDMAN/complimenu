class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    redirect_to "#{items_path}##{params[:format].downcase}" if params[:format]
    @category_items = Item.grouped_by_category

    @item_orders = ItemOrder.grouped_by_item(session[:order_id])
  end
end
