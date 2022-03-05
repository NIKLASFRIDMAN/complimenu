class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    redirect_to "#{items_path}##{params[:format].downcase}" if params[:format]
    @catitems = {}
    items = Item.all
    categories = Item.distinct.pluck(:category)
    categories.each do |category|
      
      item_order = ItemOrder.includes(:item)
                            .joins(:item)
                            .where(item: {category: category})
                            
      @catitems[category.to_sym] = item_order
      # items_cat = items.select { |i| i.category = category }
      # itemorders = ItemOrder.all
      # @catitems[category.to_sym] = []
      # items_cat.each do |item|
      #   @catitems[category.to_sym] << { item: item,
      #                                   item_order: itemorders.select { |io| io.item_id == item.id && io.order_id == session[:order_id] }[0] }
      # end
    end
  end
end
