class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    order = Order.new
    order.save!
    session[:order_id] = order.id
  end
end
