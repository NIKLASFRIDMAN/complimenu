class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      @order = Order.new
      @order.save!
      session[:order_id] = @order.id
    end
  end
end
