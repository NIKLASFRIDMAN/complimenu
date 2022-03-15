class TablesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_table
  def show
    if Order.find_by(table_id: params[:id])
      @order = Order.find_by(table_id: params[:id])
      session[:order_id] = @order.id
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
      @users = User.where(table_id: @table.id)
      TableroomChannel.broadcast_to(
        @table,
        render_to_string(partial: "shared/navbar", locals: { users: @users})
      )
      sign_in(:user, @user)
    end
    @users = User.where(table_id: @table.id)
  end

  private
  def find_table
    @table = Table.find(params[:id])
  end
end
