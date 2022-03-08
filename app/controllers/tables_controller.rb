class TablesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_table
  def show
    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      @order = Order.new
      @order.table = find_table
      @order.save!
      session[:order_id] = @order.id
    end
    @categories = Item.distinct.pluck(:category)
    unless current_user
      @user = User.new
      @user.table = @table
      @user.save
      sign_in(:user, @user)
    end
  end

  private

  def find_table
    @table = Table.find(params[:id])
  end
end
