class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]
  before_action :find_order, only: [:new, :create]
  before_action :find_table
  before_action :find_user

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    item_order = ItemOrder.find_by(order_id: session[:order_id])
    item = item_order.item
    @review.order = @order
    @review.item = item
    respond_to do |format|
      if @review.save
        format.json
      else
        render :new
      end
    end
  end

  def success; end

  private

  def find_order
    @order = Order.find(session[:order_id])
  end

  def review_params
    params.require(:review).permit(:upvote, :downvote)
  end

  def find_table
    @table = Table.find(params[:table_id])
  end

  def find_user
    @users = User.where(table_id: @table.id)
  end

end
