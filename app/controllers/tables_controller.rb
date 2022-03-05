class TablesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_table
  def show
    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      @order = Order.new
      @order.table = Table.find(params[:id])
      @order.save!
      session[:order_id] = @order.id
    end
    @categories = Item.distinct.pluck(:category)
    find_table
  end

  private

  def find_table
    @table = Table.find(params[:id])
  end
end
