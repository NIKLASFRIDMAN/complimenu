class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    redirect_to "#{items_path}##{params[:format].downcase}" if params[:format]
    @category_items = Item.joins(:item_orders)
                          .group_by { |item| item.category }

    @item_orders = ItemOrder.joins(:item)
                            .where(order_id: session[:order_id])
                            .group_by { |item_order| item_order.item.id }
  end
end
