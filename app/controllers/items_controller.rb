class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    redirect_to "#{items_path}##{params[:format].downcase}" if params[:format]
    @catitems = ItemOrder.includes(:item)
                         .distinct
                         .group_by { |item_order| item_order.item.category }
  end
end
