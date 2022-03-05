class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    redirect_to "#{items_path}##{params[:format].downcase}" if params[:format]
    @catitems = {}
    items = Item.all
    itemorders = ItemOrder.all
    items.map(&:category).uniq.each do |category|
      items_cat = items.select { |i| i.category = category }
      @catitems[category.to_sym] = []
      items_cat.each do |item|
        @catitems[category.to_sym] << { item: item,
                                        item_order: itemorders.select { |io| io.item_id == item.id && io.order_id == session[:order_id] }[0] }
      end
    end
    @total_items = total_items(itemorders)
  end
end

private

def total_items(itemorders)
  total_items = 0
  itemorders.each do |itemorder|
    total_items += itemorder.quantity
  end
  return total_items
end
