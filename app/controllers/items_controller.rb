class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = []
    @items.each do |item|
      @categories << item.category
    end
    return @categories.uniq!
  end
end
