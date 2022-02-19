class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
  end
end
