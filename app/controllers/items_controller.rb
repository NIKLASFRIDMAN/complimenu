class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
  end
end
