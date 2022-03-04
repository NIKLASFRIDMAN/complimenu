class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if params[:format]
      redirect_to "#{items_path}##{params[:format].downcase}"
    end
    @categories = Item.distinct.pluck(:category)
    @catitems = {}
    @categories.each do |category|
      @catitems[category.to_sym] = Item.where("category = '#{category}'")
    end
  end
end
