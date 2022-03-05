class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    redirect_to "#{items_path}##{params[:format].downcase}" if params[:format]
    @category_items = Item.includes(:item_orders)
                          .distinct
                          .group_by { |item| item.category }
    @item_orders = ItemOrder.joins(:item)
                            .where(order_id: 3)
                            .group_by { |item_order| item_order.item.id }
  end
end
