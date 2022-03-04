class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    redirect_to "#{items_path}##{params[:format].downcase}" if params[:format]
    @catitems = {}
    Item.distinct.pluck(:category).each do |category|
      items = Item.where("category = '#{category}'")
      itemorders = ItemOrder.all
      @catitems[category.to_sym] = []
      items.each do |item|
        @catitems[category.to_sym] << { item: item,
                                        item_order: itemorders.select { |io| io.item_id == item.id && io.order_id == session[:order_id] }[0] }
      end
    end
  end
end
