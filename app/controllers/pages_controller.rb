class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :qrcode ]

  def home
    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      @order = Order.new
      @order.table = Table.first
      @order.save!
      session[:order_id] = @order.id
    end
     @categories = Item.distinct.pluck(:category)
  end

  def qrcode
  end
end
