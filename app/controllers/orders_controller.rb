class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:checkout]

  def checkout
  end
end
