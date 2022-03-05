class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :find_table
  def index
    redirect_to "#{table_items_path(@table)}##{params[:format].downcase}" if params[:format]
    @catitems = {}
    items = Item.all
    items.map(&:category).uniq.each do |category|
      items_cat = items.select { |i| i.category = category }
      itemorders = ItemOrder.all
      @catitems[category.to_sym] = []
      items_cat.each do |item|
        @catitems[category.to_sym] << { item: item,
                                        item_order: itemorders.select { |io| io.item_id == item.id && io.order_id == session[:order_id] }[0] }
      end
    end
  end

  private

  def find_table
    @table = Table.find(params[:table_id])
  end
end
