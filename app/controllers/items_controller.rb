class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if params[:format]
      redirect_to "#{items_path}##{params[:format].downcase}"
    end
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
  end
end
